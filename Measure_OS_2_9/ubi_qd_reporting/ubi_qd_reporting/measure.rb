# see the URL below for information on how to write OpenStudio measures
# http://nrel.github.io/OpenStudio-user-documentation/reference/measure_writing_guide/

require 'erb'
require "#{File.dirname(__FILE__)}/resources/os_lib_helper_methods.rb"

#start the measure
class UbiQdReporting < OpenStudio::Ruleset::ReportingUserScript

  # human readable name
  def name
    "UbiQD Reporting"
  end

  # human readable description
  def description
    "Report PV"
  end

  # human readable description of modeling approach
  def modeler_description
    "Report measure"
  end

  # define the arguments that the user will input
  def arguments()
    # report measure does not require any user arguments, return an empty list
    args = OpenStudio::Ruleset::OSArgumentVector.new
  end 
  
  # return a vector of IdfObjects to request EnergyPlus objects needed by the run method
  def energyPlusOutputRequests(runner, user_arguments)
    super(runner, user_arguments)
    
    result = OpenStudio::IdfObjectVector.new
    
    # use the built-in error checking 
    if !runner.validateUserArguments(arguments(), user_arguments)
      return result
    end
    
    request = OpenStudio::IdfObject.load("Output:Variable,,Site Outdoor Air Drybulb Temperature,Hourly;").get
    result << request
    
    result
  end
  
 # sql_query method
  def sql_query(runner, sql, report_name, query)
    val = nil
    result = sql.execAndReturnFirstDouble("SELECT Value FROM TabularDataWithStrings WHERE ReportName='#{report_name}' AND #{query}")
    if result.empty?
      runner.registerWarning("Query failed for #{report_name} and #{query}")
    else
      begin
        val = result.get
      rescue
        val = nil
        runner.registerWarning('Query result.get failed')
      end
    end

    val
  end

  # optional outputs to be displayed in PAT 
  def outputs 
    result = OpenStudio::Measure::OSOutputVector.new
    result << OpenStudio::Measure::OSOutput.makeDoubleOutput('panel_dc_gen_gj') # GJ
    result << OpenStudio::Measure::OSOutput.makeDoubleOutput('panel_dc_gen_kwh') # kWh
    result << OpenStudio::Measure::OSOutput.makeDoubleOutput('building_area_ip') # ft^2
    result << OpenStudio::Measure::OSOutput.makeDoubleOutput('capacity_factor') # ratio
    return result
  end

  # define what happens when the measure is run
  def run(runner, user_arguments)
    super(runner, user_arguments)

    # use the built-in error checking 
    if !runner.validateUserArguments(arguments(), user_arguments)
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

    #
    # get building PV generation directly from BIPV panels
    # using: [Output:Variable,*,Generator Produced DC Electric Energy,Annual;] from E+
    panel_dc_gen = 0.0
    environment = "RUN PERIOD 1"
    series = "Generator Produced DC Electric Energy"
    model.getGeneratorPhotovoltaics.each do |gp|
      name = gp.name.get
      key = name.upcase
      optvalue = sqlFile.runPeriodValue(environment,series, key)
      # test if the optional is good, if so add to the value
      if not optvalue.empty? then
        panel_dc_gen += optvalue.get
      else
        optseries = sqlFile.timeSeries(environment, 'Run Period', series, key)
        if not optseries.empty? then
          panel_dc_gen += optseries.get.values(0)
        else
          puts 'Failed to find ' + key
        end
      end
    end
    panel_dc_gen_gj = panel_dc_gen * 1E-9 # convert J-->GJ
    panel_dc_gen_kwh = panel_dc_gen_gj * 277.778 # convert GJ --> kWh
    runner.registerInfo("Generator produced DC electric energy (GJ): #{panel_dc_gen_gj.round(2)} (#{panel_dc_gen_kwh} kWh)")
    runner.registerValue('panel_dc_gen_gj', panel_dc_gen_gj.round(2), 'GJ')
    runner.registerValue('panel_dc_gen_kwh', panel_dc_gen_kwh.round(2), 'kWh')

    # building area
    building_area = model.getBuilding.floorArea
    building_area_ip = OpenStudio.convert(building_area, 'm^2', 'ft^2').get
    runner.registerInfo("Building Area: #{building_area_ip.round(0)} ft^2")
    runner.registerValue('building_area_ip', building_area_ip.round(0), 'ft^2')

    # capacity factor
    upstream_var = OsLib_HelperMethods.check_upstream_measure_for_arg(runner, 'system_rated_output')
    system_rated_output = upstream_var[:value].to_f
    system_ideal_energy_production = system_rated_output * 31636000 # assumed running at peak all seconds in a year, (j)
    # account for base case (zero output)
    capacity_factor = panel_dc_gen.to_f > 0 ? panel_dc_gen.to_f / system_ideal_energy_production : 0.0 # watts, joules, oh my!
    runner.registerInfo("Capacity Factor: #{capacity_factor.round(4)}")
    runner.registerValue('capacity_factor', capacity_factor.round(4), '%')

    # put data into the local variable 'output', all local variables are available for erb to use when configuring the input html file

    output =  "Measure Name = " << name << "<br>"
    output << "Building Name = " << model.getBuilding.name.get << "<br>"
    output << "Floor Area = " << model.getBuilding.floorArea.to_s << "<br>"
    output << "Net Site Energy = " << sqlFile.netSiteEnergy.to_s << " (GJ)<br>"
    output << "Panel Total PV Generation = " << panel_dc_gen_kwh.to_s << " (kwh)<br>"
    output << "Capacity Factor = " << capacity_factor.to_s << "<br>"

    # read in template
    html_in_path = "#{File.dirname(__FILE__)}/resources/report.html.in"
    if File.exist?(html_in_path)
        html_in_path = html_in_path
    else
        html_in_path = "#{File.dirname(__FILE__)}/report.html.in"
    end
    html_in = ""
    File.open(html_in_path, 'r') do |file|
      html_in = file.read
    end

    # get the weather file run period (as opposed to design day run period)
    ann_env_pd = nil
    sqlFile.availableEnvPeriods.each do |env_pd|
      env_type = sqlFile.environmentType(env_pd)
      if env_type.is_initialized
        if env_type.get == OpenStudio::EnvironmentType.new("WeatherRunPeriod")
          ann_env_pd = env_pd
          break
        end
      end
    end

    # only try to get the annual timeseries if an annual simulation was run
    if ann_env_pd

      # get desired variable
      key_value =  "Environment"
      time_step = "Hourly" # "Zone Timestep", "Hourly", "HVAC System Timestep"
      variable_name = "Site Outdoor Air Drybulb Temperature"
      output_timeseries = sqlFile.timeSeries(ann_env_pd, time_step, variable_name, key_value) # key value would go at the end if we used it.
      
      if output_timeseries.empty?
        runner.registerWarning("Timeseries not found.")
      else
        runner.registerInfo("Found timeseries.")
      end
    else
      runner.registerWarning("No annual environment period found.")
    end
    
    # configure template with variable values
    renderer = ERB.new(html_in)
    html_out = renderer.result(binding)
    
    # write html file
    html_out_path = "./report.html"
    File.open(html_out_path, 'w') do |file|
      file << html_out
      # make sure data is written to the disk one way or the other
      begin
        file.fsync
      rescue
        file.flush
      end
    end

    # close the sql file
    sqlFile.close()

    return true
 
  end

end

# register the measure to be used by the application
UbiQdReporting.new.registerWithApplication
