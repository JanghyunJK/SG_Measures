require 'erb'
require 'time'
require 'csv'

#start the measure
class ExportTimeSeriesDatatoCSV < OpenStudio::Ruleset::ReportingUserScript
  
  #define the name that a user will see, this method may be deprecated as
  #the display name in PAT comes from the name field in measure.xml
  def name
    return "ExportTimeSeriesDatatoCSV"
  end
  
  #define the arguments that the user will input
  def arguments()
    args = OpenStudio::Ruleset::OSArgumentVector.new

    #make an argument for days to report
    # days_to_report = OpenStudio::Ruleset::OSArgument::makeIntegerArgument("days_to_report",true)
    # days_to_report.setDisplayName("Days to Report")
    # days_to_report.setDefaultValue(5)
    # args << days_to_report

    return args
  end #end the arguments method

  def energyPlusOutputRequests(runner, user_arguments)
    super(runner, user_arguments)
    result = OpenStudio::IdfObjectVector.new

    # 'Output:Variable,key,variable,frequency'
    # result << OpenStudio::IdfObject.load('Output:Meter,InteriorLights:Electricity,timestep;').get
    # result << OpenStudio::IdfObject.load('Output:Meter,InteriorEquipment:Electricity,timestep;').get
    # result << OpenStudio::IdfObject.load('Output:Meter,Fans:Electricity,timestep;').get
    # result << OpenStudio::IdfObject.load('Output:Meter,Heating:Electricity,timestep;').get
    # result << OpenStudio::IdfObject.load('Output:Meter,Heating:NaturalGas,timestep;').get
    # result << OpenStudio::IdfObject.load('Output:Meter,Cooling:Electricity,timestep;').get
    # result << OpenStudio::IdfObject.load('Output:Variable,,Facility Total HVAC Electric Demand Power,timestep;').get
    # result << OpenStudio::IdfObject.load('Output:Variable,,Fan Electric Energy,timestep;').get
    # result << OpenStudio::IdfObject.load('Output:Variable,,Heating Coil Heating Energy,timestep;').get
    #result << OpenStudio::IdfObject.load('Output:Variable,,Site Outdoor Air Relative Humidity,timestep;').get
    #result << OpenStudio::IdfObject.load('Output:Variable,,Site Outdoor Air Wetbulb Temperature,timestep;').get
    #result << OpenStudio::IdfObject.load('Output:Variable,,Site Outdoor Air Drybulb Temperature,timestep;').get
    #result << OpenStudio::IdfObject.load('Output:Variable,,Site Diffuse Solar Radiation Rate per Area,timestep;').get
    #result << OpenStudio::IdfObject.load('Output:Variable,,Site Direct Solar Radiation Rate per Area,timestep;').get
    #result << OpenStudio::IdfObject.load('Output:Variable,,Site Rain Status,timestep;').get
    #result << OpenStudio::IdfObject.load('Output:Variable,,Zone Mean Air Temperature,timestep;').get
    #result << OpenStudio::IdfObject.load('Output:Variable,,System Node Temperature,timestep;').get
    #result << OpenStudio::IdfObject.load('Output:Variable,,System Node Current Density Volume Flow Rate,timestep;').get
    #result << OpenStudio::IdfObject.load('Output:Variable,,Site Outdoor Air Barometric Pressure,timestep;').get
    #result << OpenStudio::IdfObject.load('Output:Variable,,Zone Air Relative Humidity,timestep;').get

    return result
  end

  def outputs
    result = OpenStudio::Measure::OSOutputVector.new

    result << OpenStudio::Measure::OSOutput.makeDoubleOutput('value_want_in_results_csv') # ft (gui doesn't pull units in for you)

    return result
  end

  #define what happens when the measure is run
  def run(runner, user_arguments)
    super(runner, user_arguments)

    #use the built-in error checking
    if not runner.validateUserArguments(arguments(), user_arguments)
      return false
    end

    runner.registerValue('value_want_in_results_csv',9999,"ft") # skip units arg if you are keeping a string

    # Get the user inputs
    # days_to_report = runner.getIntegerArgumentValue("days_to_report",user_arguments)
    days_to_report = 365

    # Check that user requested between 1 and 365 days
    if days_to_report < 1 or days_to_report > 365
      runner.registerError("You requested #{days_to_report} days. Must be between 1 and 365.")
      return false
    end

    # get the last model and sql file
    model = runner.lastOpenStudioModel
    if model.empty?
      runner.registerError("Cannot find last model.")
      return false
    end
    model = model.get

    sqlFile = runner.lastEnergyPlusSqlFile
    if sqlFile.empty?
      runner.registerError("Cannot find last sql file.")
      return false
    end
    sqlFile = sqlFile.get
    model.setSqlFile(sqlFile)

    #get the weather file run period (as opposed to design day run period)
    ann_env_pd = nil
    sqlFile.availableEnvPeriods.each do |env_pd|
      env_type = sqlFile.environmentType(env_pd)
      if env_type.is_initialized
        if env_type.get == OpenStudio::EnvironmentType.new("WeatherRunPeriod")
          ann_env_pd = env_pd
        end
      end
    end

    sql_start_time = Time.new
    csv_array = []
    output_time_series = {}
    reporting_frequency = "Zone Timestep"
	  header = ["OS_time"]
    timeseriesinfo = nil
    variableNames = sqlFile.availableVariableNames(ann_env_pd, reporting_frequency)
    variableNames.each do |variableName|
      keyValues = sqlFile.availableKeyValues(ann_env_pd, reporting_frequency, variableName.to_s)
      keyValues.each do |keyValue|
        timeseries = sqlFile.timeSeries(ann_env_pd, reporting_frequency, variableName.to_s, keyValue.to_s)
        if timeseries.is_initialized
          timeseries = timeseries.get
          timeseriesinfo = timeseries
          if timeseries.units == "J"
            if keyValue != ""
              header << "#{r_col("#{keyValue.to_s}:#{variableName.to_s}")} [W]"
            else
              header << "#{r_col("#{variableName.to_s}")} [W]"
            end
            output_time_series[header[-1]] = timeseries / timeseries.intervalLength.get.totalSeconds
          else
            if keyValue != ""
              header << "#{r_col("#{keyValue.to_s}:#{variableName.to_s}")} [#{timeseries.units}]"
            else
              header << "#{r_col("#{variableName.to_s}")} [#{timeseries.units}]"
            end
            output_time_series[header[-1]] = timeseries
          end
        end
      end
    end

    # Retrieve the requisite meter set - this is quite annoying
    meter_list = [
      # 'Electricity:Facility', 
      # 'NaturalGas:Facility', 
      # 'InteriorLights:Electricity', 
      # 'InteriorEquipment:Electricity',
      # 'Fans:Electricity', 
      # 'Heating:Electricity', 
      # 'Heating:NaturalGas', 
      # 'Cooling:Electricity'
    ]
    electricity_energy_modeled = []
    gas_energy_modeled = []
    electricity_energy_modeled_os_vec = NIL
    gas_energy_modeled_os_vec = NIL
    meter_list.each do |meter|
      key_value = ''
      timeseries = sqlFile.timeSeries(ann_env_pd, reporting_frequency, meter, key_value)
      if timeseries.is_initialized
        timeseries = timeseries.get
        timeseriesinfo = timeseries
        if timeseries.units == "J"
          header << "#{r_col("#{meter.to_s}")} [W]"
          output_time_series[header[-1]] = timeseries / timeseries.intervalLength.get.totalSeconds
        else
          header << "#{r_col("#{meter.to_s}")} [#{timeseries.units}]"
          output_time_series[header[-1]] = timeseries
        end
        if meter == 'Electricity:Facility'
          electricity_energy_modeled_os_vec = output_time_series[header[-1]].values
          electricity_energy_modeled = []
        elsif meter == 'NaturalGas:Facility'
          gas_energy_modeled_os_vec = output_time_series[header[-1]].values
          gas_energy_modeled = []
        end
      else
        runner.registerInfo "Unable to retrieve timeseries for #{meter}"
      end
    end

    runner.registerInfo("The time series interval length is #{timeseriesinfo.intervalLength.get}, which in seconds totals #{timeseriesinfo.intervalLength.get.totalSeconds}.")
	  csv_array << header
    sql_end_time = Time.new
    ts_times = output_time_series[output_time_series.keys[0]].dateTimes
    num_time_steps = ts_times.size - 1
    end_date = ts_times[num_time_steps]
    start_date = end_date - OpenStudio::Time.new(days_to_report,0,0,0)

    # for i in 0..num_time_steps
    #   electricity_energy_modeled << electricity_energy_modeled_os_vec[i]
    #   gas_energy_modeled << gas_energy_modeled_os_vec[i]
    # end

    pre_values = {}
    for key in output_time_series.keys
      pre_values[key] = output_time_series[key].values
    end

    for i in 0..num_time_steps
      time = ts_times[i]
      next if time <= start_date or time > end_date
      row = []
      row << time
  	  for key in header[1..-1]
        val = pre_values[key][i]
        row << val
      end
      csv_array << row
    end

    end_time = Time.new

    puts "SQL time #{sql_end_time-sql_start_time}"
    puts "Loop time #{end_time-sql_end_time}"

    File.open("./sensors.csv", 'wb') do |file|
      csv_array.each do |elem|
        file.puts elem.join(',')
      end
    end

    begin
      dpid = runner.datapoint
      runner.registerInfo "retrieved datapoint id '#{dpid}' of class '#{dpid.class.name}'"
    rescue => e
      runner.registerInfo "runner.datapoint errored with #{e.message} in #{e.backtrace.join('\n')}"
    end

    runner.registerInfo("Time series data file saved in #{File.expand_path('.')}.")

    # # Create the severity matrix
    # baseline = CSV.read("#{File.dirname(__FILE__)}/resources/knoxville_baseline.csv").transpose
    # electricity_energy_baseline = baseline[0][1..-1].map { |str| str.to_f }
    # gas_energy_baseline = baseline[1][1..-1].map { |str| str.to_f }
    # header = [baseline[0][0], baseline[1][0]]
    # electricity_error = electricity_energy_baseline.zip(electricity_energy_modeled).map { |x, y| (x - y) / x }
    # gas_error = gas_energy_baseline.zip(gas_energy_modeled).map { |x, y| (x - y) / x }
    # electricity_severity = []
    # electricity_error.each do |val|
    #   if val.abs >= 0.15
    #     electricity_severity << 'high'
    #   elsif val.abs >= 0.10
    #     electricity_severity << 'mid'
    #   elsif val.abs >= 0.05
    #     electricity_severity << 'low'
    #   else
    #     electricity_severity << 'none'
    #   end
    # end
    # gas_severity = []
    # gas_error.each do |val|
    #   if val.abs >= 0.15
    #     gas_severity << 'high'
    #   elsif val.abs >= 0.10
    #     gas_severity << 'mid'
    #   elsif val.abs >= 0.05
    #     gas_severity << 'low'
    #   else
    #     gas_severity << 'none'
    #   end
    # end

    # # Write the severity matrix to file
    # File.open("./severity.csv", 'wb') do |file|
    #   file.puts header.join(',')
    #   for i in 0..(electricity_severity.length-1)
    #     file.puts [electricity_severity[i], gas_severity[i]].join(',')
    #   end
    # end

    #closing the sql file
    sqlFile.close()

    return true

  end #end the run method

  def r_col(eplus_col)
    return eplus_col.gsub(/\s\[.+/,"").gsub(": ","_").gsub(":","_").gsub(" ","_").downcase
  end

end #end the measure

#this allows the measure to be use by the application
ExportTimeSeriesDatatoCSV.new.registerWithApplication