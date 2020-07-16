require 'openstudio-standards'
require "#{File.dirname(__FILE__)}/resources/os_lib_schedules.rb"
require "#{File.dirname(__FILE__)}/resources/os_lib_helper_methods.rb"


class AddRedirectingBIPVWithPCESchedule < OpenStudio::Measure::ModelMeasure

  # human-readable name
  def name
    return "Add Redirecting BIPV with PCE Schedule"
  end

  # summary description
  def description
    return "Add 'UbiQD' PV technology to windows"
  end

  # description of modeling approach
  def modeler_description
    return "Adds PV to selected windows. Efficiency is scaled to represent theoretical efficiency of quantum dot energy redirection to PV mounted in IGU framing. Scaling factors for QD impacts on visible transmittance and SHGC are provided"
  end

  # define the user arguments
  def arguments(model)
    args = OpenStudio::Ruleset::OSArgumentVector.new

    # PV surface QD coverage (%)
    dot_coverage = OpenStudio::Ruleset::OSArgument.makeDoubleArgument("dot_coverage", true)
    dot_coverage.setDisplayName("QD Surface Coverage")
    dot_coverage.setUnits("fraction")
    dot_coverage.setDefaultValue(1.0)
    args << dot_coverage
    
    # make an argumet for removing existing
    pce_type = OpenStudio::Ruleset::OSArgument::makeBoolArgument('pce_type', true)
    pce_type.setDisplayName('PV power conversion efficiency based on schedule?')
    pce_type.setDefaultValue(false)
    args << pce_type

    # pv module efficiency (%)
    pv_eff = OpenStudio::Ruleset::OSArgument.makeDoubleArgument("pv_eff", true)
    pv_eff.setDisplayName("Fixed PV power conversion efficiency")
    pv_eff.setUnits("fraction")
    pv_eff.setDefaultValue(0.05)
    args << pv_eff
    
    # make an argument for file path
    folder = OpenStudio::Ruleset::OSArgument.makeStringArgument('folder', true)
    folder.setDisplayName('Path to the folder that contains schedule files')
    folder.setDescription("Example: 'C:/Projects/'")
    folder.setDefaultValue("C:/Users/JKIM4/Box Sync/Project Files/5 NEXT_SwitchGlaze/SimulationResults")
    args << folder
    
    # temporary argument
    wwr = OpenStudio::Ruleset::OSArgument.makeDoubleArgument('wwr', true)
    wwr.setDisplayName('temporary argument: window wall ratio scenario')
    wwr.setDefaultValue(0.4)
    args << wwr
    
    # temporary argument
    ori = OpenStudio::Ruleset::OSArgument.makeStringArgument('ori', true)
    ori.setDisplayName('temporary argument: PV orientation scenario')
    ori.setDefaultValue("ESW")
    args << ori
    
    # temporary argument
    switch_t = OpenStudio::Ruleset::OSArgument.makeDoubleArgument('switch_t', true)
    switch_t.setDisplayName('temporary argument: thermochromic switching temperature scenario')
    switch_t.setDefaultValue(10.0)
    args << switch_t

    inverter_eff = OpenStudio::Ruleset::OSArgument.makeDoubleArgument("inverter_eff", true)
    inverter_eff.setDisplayName("Inverter Efficiency")
    inverter_eff.setUnits("fraction")
    inverter_eff.setDefaultValue(1.0)
    args << inverter_eff

    # facades to receive BIPV
    choices = OpenStudio::StringVector.new
    choices << "N"
    choices << "E"
    choices << "S"
    choices << "W"
    choices << "ESW"  # !north
    choices << "ALL"
    choices << "NONE" # for baseline
    facade = OpenStudio::Ruleset::OSArgument::makeChoiceArgument("facade", choices)
    facade.setDisplayName("facade")
    facade.setDefaultValue("ESW")
    args << facade

    debug_mode = OpenStudio::Ruleset::OSArgument::makeBoolArgument('debug_mode', false)
    debug_mode.setDisplayName('Debug Mode')
    debug_mode.setDefaultValue('false')
    debug_mode.setDescription('Print debugging info')
    args << debug_mode

    return args
  end

  def log_info(str)
    @runner.registerInfo(str)
  end

  # optional outputs to be displayed in PAT 
  def outputs 
    result = OpenStudio::Measure::OSOutputVector.new
    result << OpenStudio::Measure::OSOutput.makeDoubleOutput('panel_rated_output') # w/m^2
    result << OpenStudio::Measure::OSOutput.makeDoubleOutput('panel_rated_output_ip') # w/ft^2
    result << OpenStudio::Measure::OSOutput.makeDoubleOutput('system_rated_output') # w
    result << OpenStudio::Measure::OSOutput.makeDoubleOutput('pv_area_total_ip') # w\ft^2
    result << OpenStudio::Measure::OSOutput.makeStringOutput('facade') # w\ft^2
    return result
  end

  def run(model, runner, user_arguments)
    super(model, runner, user_arguments)

    # use the built-in error checking
    if !runner.validateUserArguments(arguments(model), user_arguments)
      return false
    end

    # assign the user inputs to variables
    dot_coverage = runner.getDoubleArgumentValue('dot_coverage',user_arguments)
    pv_eff = runner.getDoubleArgumentValue('pv_eff',user_arguments)
    inverter_eff = runner.getDoubleArgumentValue('inverter_eff',user_arguments)
    panel_rated_output = (dot_coverage * pv_eff) * 1000 #w/m^2 (basis 50w/m^2, 0.05 eff, 0.50 coverage (5% conversion, 1Kw/m^2))
    facade = runner.getStringArgumentValue('facade',user_arguments)
    debug_mode = runner.getStringArgumentValue('debug_mode',user_arguments)
    
    ######################################################
    ######################################################
    folder = runner.getStringArgumentValue('folder', user_arguments)
    pce_type = runner.getBoolArgumentValue('pce_type', user_arguments)
    wwr = runner.getDoubleArgumentValue('wwr', user_arguments)
    ori = runner.getStringArgumentValue('ori', user_arguments)
    switch_t = runner.getDoubleArgumentValue('switch_t', user_arguments)
    ######################################################
    ######################################################
    
    if facade == "NONE"
      return false
    end

    # create shared shading transmittance schedule (to mimic the quantum dots' obscuration)
    #target_transmittance = 1.0 - dot_coverage.to_f
	  target_transmittance = 1.0
    inputs = {
        'name' => "PV Shading Transmittance Schedule",
        'winterTimeValuePairs' => { 24.0 => target_transmittance },
        'summerTimeValuePairs' => { 24.0 => target_transmittance },
        'defaultTimeValuePairs' => { 24.0 => target_transmittance }
    }
    shading_surface_transmittance_schedule = OsLib_Schedules.createSimpleSchedule(model,inputs)

    # get the windows
    ext_windows = []
    model.getSubSurfaces.each do |s|
      ext_windows << s if s.subSurfaceType == "FixedWindow" && s.outsideBoundaryCondition == "Outdoors"
    end

    # report initial condition
    runner.registerInitialCondition("Input building contains #{ext_windows.size.to_s} exterior windows")

    # get user selection set
    candidate_windows = []
    if facade == "NONE"
      # base case, do nothing.
    else
      ext_windows.each do |s|
        azimuth = OpenStudio::Quantity.new(s.azimuth,OpenStudio::createSIAngle)
        azimuth = OpenStudio::convert(azimuth,OpenStudio::createIPAngle).get.value
        if facade == "ALL"
          candidate_windows << s
          next
        end
        candidate_windows << s if (azimuth >= 315.0 or azimuth < 45.0) && facade == 'N'
        candidate_windows << s if (azimuth >= 45.0 and azimuth < 135.0) && facade == 'E'
        candidate_windows << s if (azimuth >= 135.0 and azimuth < 225.0) && facade == 'S'
        candidate_windows << s if (azimuth >= 225.0 and azimuth < 315.0) && facade == 'W'
        candidate_windows << s if (azimuth >= 45.0 and azimuth < 315.0) && facade == 'ESW'
      end
    end
    runner.registerInfo("#{candidate_windows.size.to_s} windows meet facade selection criteria (facade = '#{facade}')")

    # create the inverter
    inverter = OpenStudio::Model::ElectricLoadCenterInverterSimple.new(model)
    inverter.setInverterEfficiency(inverter_eff)
    runner.registerInfo("Created inverter with efficiency of #{inverter.inverterEfficiency}")

    # create the distribution system
    elcd = OpenStudio::Model::ElectricLoadCenterDistribution.new(model)
    elcd.setInverter(inverter)
    elcd.setName('UbiQD - Distribution')

    pv_area_total = 0.0
    system_rated_output = 0.0

    candidate_windows.each do |surface|

      # make single shading surface group for each window
      shading_surface_group = OpenStudio::Model::ShadingSurfaceGroup.new(model)
      # set the space on the shading group
      shading_surface_group.setSpace(surface.space.get) if surface.space.is_initialized

      vec = surface.outwardNormal
      vec = vec
      vec.setLength(0.0254) # PV surface projection in meters

      # get window points and project along window normal
      vertices = surface.vertices

      transform = OpenStudio::Transformation.new
      transform = surface.space.get.transformation if surface.space.is_initialized

      # transform to world coords
      vertices = transform * vertices

      points = []
      vertices.each do |f|
        if debug_mode
          runner.registerInfo("window vertex: #{f}, projected PV vertex: #{f + vec}")
        end
        pp = f + vec
        points << pp
      end

      points = transform.inverse * points # send back to space coords

      # PV surface
      shading_surface = OpenStudio::Model::ShadingSurface.new(points, model)
      pv_area = OpenStudio::getArea(shading_surface.vertices()).get
      pv_area_total += pv_area
      pv_area_ip = OpenStudio.convert(pv_area, "m^2", "ft^2")
      shading_surface.setShadingSurfaceGroup(shading_surface_group)
      shading_surface.setName("PV - #{surface.name}")
      shading_surface.setTransmittanceSchedule(shading_surface_transmittance_schedule)
      panel = OpenStudio::Model::GeneratorPhotovoltaic::simple(model)
      panel.setSurface(shading_surface)
      
      ######################################################
      ######################################################
      # check file path for reasonableness
      
      azimuth = OpenStudio::Quantity.new(surface.azimuth,OpenStudio::createSIAngle)
      azimuth = OpenStudio::convert(azimuth,OpenStudio::createIPAngle).get.value
      azimuth = azimuth.round(1)
      
      if pce_type
        schedule_name = "PCE_Sch_#{wwr}_#{ori}_#{switch_t}_#{azimuth}"
      
        file_path = "#{folder}/#{schedule_name}.csv"
      
        runner.registerInfo("azimuth = #{azimuth}")
        runner.registerInfo("PCE Schedule path = #{file_path}")
      
        if file_path.empty?
          runner.registerError('Empty file path was entered.')
          return false
        end

        # strip out the potential leading and trailing quotes
        file_path.gsub!('"', '')

        # check if file exists
        if !File.exist? file_path
          runner.registerError("The file at path #{file_path} doesn't exist.")
          return false
        end 
    
        # read in csv values
        csv_values = CSV.read(file_path,{headers: false, converters: :float})
        num_rows = csv_values.length

        # create values for the timeseries
        schedule_values = OpenStudio::Vector.new(num_rows, 0.0)
        csv_values.each_with_index do |csv_value,i|
          schedule_values[i] = csv_value[0]
        end

        # infer interval
        interval = []
        if (num_rows == 8760) || (num_rows == 8784) #h ourly data
          interval = OpenStudio::Time.new(0, 1, 0)
        elsif (num_rows == 35_040) || (num_rows == 35_136) # 15 min interval data
          interval = OpenStudio::Time.new(0, 0, 15)
        else
          runner.registerError('This measure does not support non-hourly or non-15 min interval data.  Cast your values as 15-min or hourly interval data.  See the values template.')
          return false
        end

        # make a schedule
        startDate = OpenStudio::Date.new(OpenStudio::MonthOfYear.new(1), 1)
        timeseries = OpenStudio::TimeSeries.new(startDate, interval, schedule_values, 'unitless')
        schedule = OpenStudio::Model::ScheduleInterval::fromTimeSeries(timeseries, model)
        if schedule.empty?
          runner.registerError("Unable to make schedule from file at '#{file_path}'")
          return false
        end
        schedule = schedule.get
        schedule.setName(schedule_name) 
      end
      ######################################################
      ######################################################

      runner.registerInfo("added PV panel area: #{pv_area.round(2)} m^2 (#{pv_area_ip} ft^2)") if debug_mode
	    panel_output = panel_rated_output * pv_area
	    runner.registerInfo("added PV panel output: #{panel_output.round(1)} W (#{pv_area} m^2)") if debug_mode

	    panel.setRatedElectricPowerOutput(panel_output)
	  
      performance = panel.photovoltaicPerformance.to_PhotovoltaicPerformanceSimple.get
      performance.setFractionOfSurfaceAreaWithActiveSolarCells(dot_coverage)
      
      ######################################################
      ######################################################
      if pce_type
        performance.setEfficiencySchedule(schedule)
      else
        performance.setFixedEfficiency(pv_eff)
      end
      ######################################################
      ######################################################

      # connect panel to electric load center distribution
      elcd.addGenerator(panel)

     end

    # define outputs for server analyses

    # get num_stories_above_grade and story_multiplier from preceding measure
    # get multiplier method, expecting: ["Basements Ground Mid Top", "none"]
    story_multiplier = OsLib_HelperMethods.check_upstream_measure_for_arg(runner, 'story_multiplier')
    scaled_note = ""
    if story_multiplier[:value] == "Basements Ground Mid Top"
      scaled_note = '(scaled)'
      num_stories_above_grade = OsLib_HelperMethods.check_upstream_measure_for_arg(runner, 'num_stories_above_grade')
      pv_area_total_initial = pv_area_total
      pv_area_total = ((pv_area_total/3) * (num_stories_above_grade[:value].to_f - 2)) + ((pv_area_total/3) * 2)
      runner.registerWarning("Zone multipliers in use (story multiplier method = #{story_multiplier[:value]}).") if debug_mode
      runner.registerWarning("Scaling PV panel area to account for zone multipliers (initial: #{pv_area_total_initial}, scaled: #{pv_area_total}).") if debug_mode
    end

    # convert total to IP units
    # NOTE: OpenStudio.convert did *not* return a useable value for runner.registerValue. I tried.
    pv_area_total_ip = pv_area_total * 10.7639 # m^2 --> ft^2
    panel_rated_output_ip = panel_rated_output * 0.09290304 # w/m^2 --> w/ft^2

    system_rated_output = panel_rated_output * pv_area_total #w
    runner.registerValue("system_rated_output", system_rated_output.round(2))
    runner.registerInfo("Total system rated output is #{system_rated_output} watts, (panel: #{panel_rated_output_ip} w/ft^2 * panel area: #{pv_area_total_ip} ft^2)")
    runner.registerValue("panel_rated_output", panel_rated_output.round(2)) #w/m^2
    runner.registerValue("panel_rated_output_ip", panel_rated_output_ip.round(2)) #w/ft^2

    runner.registerValue("pv_area_total", pv_area_total.round(2)) #m^2
    runner.registerValue("pv_area_total_ip", pv_area_total_ip.round(2)) #ft^2

    runner.registerFinalCondition("#{model.getShadingSurfaces.size} PV surfaces (#{pv_area_total_ip.round(2)} ft^2 total area #{scaled_note}) added to model (facade = '#{facade}').")

    return true

  end

end

# register the measure to be used by the application
AddRedirectingBIPVWithPCESchedule.new.registerWithApplication
