require 'openstudio-standards'
require "openstudio/extension/core/os_lib_schedules.rb"
require "openstudio/extension/core/os_lib_helper_methods"


class AddThermochromicBIPV < OpenStudio::Measure::ModelMeasure

  # human-readable name
  def name
    return "Add Thermochromic BIPV"
  end

  # summary description
  def description
    return "Adds BIPV (Building Integrated Photovoltaic) on exterior façade."
  end

  # description of modeling approach
  def modeler_description
    return "Adds simple PV object for BIPV implementation. PV can be installed on opaque (wall) and/or transparent (window) façade. Power conversion efficiency of PV can be either constant or dynamic (based on hard-coded regression model reflecting solar incident angle variation). Cardinal directions (East, West, South, North, etc.) for mounting PV can be selected. BIPV on transparent façade can be either static or switching (thermochromic switching between light and dark state) window. BIPV on transparent façade with switching window can specifiy switching temperature (based on window's outermost temperature)."
  end

  # define the user arguments
  def arguments(model)
    args = OpenStudio::Ruleset::OSArgumentVector.new

    # facades to receive BIPV
    choices = OpenStudio::StringVector.new
    choices << "BIPV on transparent (window) facade"
    choices << "BIPV on opaque (wall) facade"
    choices << "BIPV on all facade"
    bipv_type = OpenStudio::Ruleset::OSArgument::makeChoiceArgument("bipv_type", choices)
    bipv_type.setDisplayName("BIPV Type")
    bipv_type.setDescription("Select different BIPV options. Currently, only supporting PVs on vertical façade.")
    bipv_type.setDefaultValue("BIPV on transparent (window) facade")
    args << bipv_type

    # IQE type for transparent facade
    choices = OpenStudio::StringVector.new
    choices << "Tnt_50%_S_I0"
    choices << "Tnt_50%_S_I0pt4"
    choices << "Tnt_50%_S_I0pt6"
    choices << "Tnt_50%_S_I0pt8"
    choices << "Tnt_50%_N_I0"
    choices << "Tnt_50%_N_I0pt4"
    choices << "Tnt_50%_N_I0pt6"
    choices << "Tnt_50%_N_I0pt8"
    choices << "Tnt_25%_N_I0"
    choices << "Tnt_25%_N_I0pt4"
    choices << "Tnt_25%_N_I0pt6"
    choices << "Tnt_25%_N_I0pt8"
    choices << "Tnt_20%_N_I0"
    choices << "Tnt_20%_N_I0pt4"
    choices << "Tnt_20%_N_I0pt6"
    choices << "Tnt_20%_N_I0pt8"
    choices << "Tnt_15%_N_I0"
    choices << "Tnt_15%_N_I0pt4"
    choices << "Tnt_15%_N_I0pt6"
    choices << "Tnt_15%_N_I0pt8"
    choices << "Tnt_10%_N_I0"
    choices << "Tnt_10%_N_I0pt4"
    choices << "Tnt_10%_N_I0pt6"
    choices << "Tnt_10%_N_I0pt8"
    choices << "Tnt_5%_N_I0"
    choices << "Tnt_5%_N_I0pt4"
    choices << "Tnt_5%_N_I0pt6"
    choices << "Tnt_5%_N_I0pt8"
    choices << "Tnt_0pt5%_N_I0"
    choices << "Tnt_0pt5%_N_I0pt4"
    choices << "Tnt_0pt5%_N_I0pt6"
    choices << "Tnt_0pt5%_N_I0pt8"
    choices << "Tr_0pt5%_N_I0"
    choices << "Tr_0pt5%_N_I0pt4"
    choices << "Tr_0pt5%_N_I0pt6"
    choices << "Tr_0pt5%_N_I0pt8"
    choices << "Tr_5%_N_I0"
    choices << "Tr_5%_N_I0pt4"
    choices << "Tr_5%_N_I0pt6"
    choices << "Tr_5%_N_I0pt8"
    choices << "V_0pt5%_N_I0"
    choices << "V_0pt5%_N_I0pt4"
    choices << "V_0pt5%_N_I0pt6"
    choices << "V_0pt5%_N_I0pt8"
    choices << "V_5%_N_I0"
    choices << "V_5%_N_I0pt4"
    choices << "V_5%_N_I0pt6"
    choices << "V_5%_N_I0pt8"
    choices << "Tr_25%_N_I0"
    choices << "Tr_25%_N_I0pt4"
    choices << "Tr_25%_N_I0pt6"
    choices << "Tr_25%_N_I0pt8"
    choices << "Tr_50%_N_I0"
    choices << "Tr_50%_N_I0pt4"
    choices << "Tr_50%_N_I0pt6"
    choices << "Tr_50%_N_I0pt8"
    choices << "Tr_50%_S_I0"
    choices << "Tr_50%_S_I0pt4"
    choices << "Tr_50%_S_I0pt6"
    choices << "Tr_50%_S_I0pt8"
    choices << "V_25%_N_I0"
    choices << "V_25%_N_I0pt4"
    choices << "V_25%_N_I0pt6"
    choices << "V_25%_N_I0pt8"
    choices << "V_50%_N_I0"
    choices << "V_50%_N_I0pt4"
    choices << "V_50%_N_I0pt6"
    choices << "V_50%_N_I0pt8"
    choices << "V_50%_S_I0"
    choices << "V_50%_S_I0pt4"
    choices << "V_50%_S_I0pt6"
    choices << "V_50%_S_I0pt8"
    iqe_transparent = OpenStudio::Ruleset::OSArgument::makeChoiceArgument("iqe_transparent", choices)
    iqe_transparent.setDisplayName("IQE Type (for BIPV on transparent façade)")
    iqe_transparent.setDescription("Select specific window name. This argument is used to create (hard coded) regression models for implementing the dynamic power conversion efficiency in this measure. This argument is also used to read specific window idf files from the disk in inject_window_specific_idf_objects measure.")
    iqe_transparent.setDefaultValue("Tnt_50%_S_I0pt8")
    args << iqe_transparent

    # IQE type for opaque facade
    choices = OpenStudio::StringVector.new
    choices << "standard"
    iqe_opaque = OpenStudio::Ruleset::OSArgument::makeChoiceArgument("iqe_opaque", choices)
    iqe_opaque.setDisplayName("IQE Type (for BIPV on opaque façade)")
    iqe_opaque.setDescription("Select cardinal direction options for mounting PV on vertial building façade.")
    iqe_opaque.setDefaultValue("standard")
    args << iqe_opaque

    # facades to install BIPV
    choices = OpenStudio::StringVector.new
    choices << "N"
    choices << "E"
    choices << "S"
    choices << "W"
    choices << "ESW"  
    choices << "ALL"
    choices << "NONE" # for baseline
    pv_orientation = OpenStudio::Ruleset::OSArgument::makeChoiceArgument("pv_orientation", choices)
    pv_orientation.setDisplayName("PV Orientation")
    pv_orientation.setDescription("Select cardinal direction options for mounting PV on vertial building façade.")
    pv_orientation.setDefaultValue("S")
    args << pv_orientation

    # thermochromic window implementation 
    switching_scenarios = OpenStudio::StringVector.new
    switching_scenarios << "Static"
    switching_scenarios << "Thermochromic"    
    switching_scenario = OpenStudio::Ruleset::OSArgument::makeChoiceArgument('switching_scenario', switching_scenarios, true)
    switching_scenario.setDisplayName("Switching Scenario")
    switching_scenario.setDescription("Select between static and switching windows. Currently, thermochromic window is only supported and electrochromic is not supported for switching windows.")
    switching_scenario.setDefaultValue("Static")
    args << switching_scenario

    # PV surface QD coverage (%)
    dot_coverage = OpenStudio::Ruleset::OSArgument.makeDoubleArgument("dot_coverage", true)
    dot_coverage.setDisplayName("PV Active Portion")
    dot_coverage.setDescription("Define fraction value of an active portion of PV from window surface area. Only the fraction defined in this argument from the window surface will act as PV surface (for electricity generation).")
    dot_coverage.setUnits("fraction")
    dot_coverage.setDefaultValue(1.0)
    args << dot_coverage

    # using IQE
    use_tint_iqe = OpenStudio::Ruleset::OSArgument::makeBoolArgument('use_tint_iqe', false)
    use_tint_iqe.setDisplayName('Dynamic PV Power Conversion Efficiency?')
    use_tint_iqe.setDescription("Select true if PV power conversion efficiency will be dynamically calculated based on regression models. If false, Fixed PV Power Conversion Efficiency (defined below) will be used.")
    use_tint_iqe.setDefaultValue('false')
    args << use_tint_iqe
    
    # pv fixed efficiency (%)
    pv_eff_trnpt = OpenStudio::Ruleset::OSArgument.makeDoubleArgument("pv_eff_trnpt", true)
    pv_eff_trnpt.setDisplayName("Fixed PV Power Conversion Efficiency (for transparent façade)")
    pv_eff_trnpt.setDescription('Define fixed power conversion efficiency for PV on transparent façade. This value is only applied if Dynamic PV Power Conversion efficiency is false and Switching Scenario selected with static window.')
    pv_eff_trnpt.setUnits("fraction")
    pv_eff_trnpt.setDefaultValue(1.0)
    args << pv_eff_trnpt  

    # pv fixed efficiency (%)
    pv_eff_opq = OpenStudio::Ruleset::OSArgument.makeDoubleArgument("pv_eff_opq", true)
    pv_eff_opq.setDisplayName("Fixed PV Power Conversion Efficiency (for opaque façade)")
    pv_eff_opq.setDescription('Define fixed power conversion efficiency for PV on opaque façade. This value is only applied if Dynamic PV Power Conversion efficiency is false and Switching Scenario selected with static window.')
    pv_eff_opq.setUnits("fraction")
    pv_eff_opq.setDefaultValue(1.0)
    args << pv_eff_opq 
    
    # pv module efficiency (%)
    pv_eff_light = OpenStudio::Ruleset::OSArgument.makeDoubleArgument("pv_eff_light", true)
    pv_eff_light.setDisplayName("Fixed PV Power Conversion Efficiency in Light State Switching Window")
    pv_eff_light.setDescription('Defined fixed power conversion efficiency for window in light state. This value is applied if Dynamic PV Power Conversion Efficiency is false and Switching Scenario selected with thermochromic window.')
    pv_eff_light.setUnits("fraction")
    pv_eff_light.setDefaultValue(0.0053)
    args << pv_eff_light
    
    # pv module efficiency (%)
    pv_eff_dark = OpenStudio::Ruleset::OSArgument.makeDoubleArgument("pv_eff_dark", true)
    pv_eff_dark.setDisplayName("Fixed PV Power Conversion Efficiency in Dark State Switching Window")
    pv_eff_dark.setDescription('Defined fixed power conversion efficiency for window in dark state. This value is applied if Dynamic PV Power Conversion Efficiency is false and Switching Scenario selected with thermochromic window.')
    pv_eff_dark.setUnits("fraction")
    pv_eff_dark.setDefaultValue(0.18)
    args << pv_eff_dark
    
    # thermochromic switching temperature
    switch_t = OpenStudio::Ruleset::OSArgument.makeDoubleArgument('switch_t', true)
    switch_t.setDisplayName('Thermochromic Switching Temperature')
    switch_t.setDescription('Define temperature value to simulate when thermochromic window swtiches between light and dark states. The reference temperature is the temperature of the outermost window layer. This value is applied if Switching Scenario is selected with thermochromic window.')
    switch_t.setUnits("C")
    switch_t.setDefaultValue(30.0)
    args << switch_t
    
    # inverter efficiency
    inverter_eff = OpenStudio::Ruleset::OSArgument.makeDoubleArgument("inverter_eff", true)
    inverter_eff.setDisplayName("Fixed Inverter Efficiency")
    inverter_eff.setDescription("Define fixed inverter efficiency.")
    inverter_eff.setUnits("fraction")
    inverter_eff.setDefaultValue(1.0)
    args << inverter_eff  

    # debug mode
    debug_mode = OpenStudio::Ruleset::OSArgument::makeBoolArgument('debug_mode', false)
    debug_mode.setDisplayName('Debug Mode')
    debug_mode.setDescription("Select true if user wants to print out more details for debugging.")
    debug_mode.setDefaultValue('false')
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
    result << OpenStudio::Measure::OSOutput.makeStringOutput('pv_orientation') # w\ft^2
    return result
  end

  def run(model, runner, user_arguments)
    super(model, runner, user_arguments)

    # use the built-in error checking
    if !runner.validateUserArguments(arguments(model), user_arguments)
      return false
    end
    
    ##########################################################################
    # assign the user inputs to variables
    ##########################################################################
    bipv_type = runner.getStringArgumentValue('bipv_type',user_arguments)
    dot_coverage = runner.getDoubleArgumentValue('dot_coverage',user_arguments)
    pv_eff_trnpt = runner.getDoubleArgumentValue('pv_eff_trnpt',user_arguments)
    pv_eff_opq = runner.getDoubleArgumentValue('pv_eff_opq',user_arguments)
    inverter_eff = runner.getDoubleArgumentValue('inverter_eff',user_arguments)
    panel_rated_output = (dot_coverage * pv_eff_trnpt) * 1000 #w/m^2 (basis 50w/m^2, 0.05 eff, 0.50 coverage (5% conversion, 1Kw/m^2))
    pv_orientation = runner.getStringArgumentValue('pv_orientation',user_arguments)
    debug_mode = runner.getStringArgumentValue('debug_mode',user_arguments)
    use_tint_iqe = runner.getStringArgumentValue('use_tint_iqe',user_arguments)
    iqe_transparent = runner.getStringArgumentValue('iqe_transparent',user_arguments)
    iqe_opaque = runner.getStringArgumentValue('iqe_opaque',user_arguments)
    switching_scenario = runner.getStringArgumentValue('switching_scenario',user_arguments)
    pv_eff_light = runner.getDoubleArgumentValue('pv_eff_light',user_arguments)
    pv_eff_dark = runner.getDoubleArgumentValue('pv_eff_dark',user_arguments)
    switch_t = runner.getDoubleArgumentValue('switch_t', user_arguments)
    
    ##########################################################################
    # hard-coded dictionary for IQE and PCE connection
    ##########################################################################
    dictionary_iqe_pce = Hash.new
    dictionary_iqe_pce = {
      # 50% VLT
      "Tnt_50%_S_I0" => [0,0,0],
      "Tnt_50%_S_I0pt4" => [0.063462,0.062819,0.13557],
      "Tnt_50%_S_I0pt6" => [0.095248,0.094249,0.13539],
      "Tnt_50%_S_I0pt8" => [0.127,0.12567,0.13539],
      "Tnt_50%_N_I0" => [0,0,0],
      "Tnt_50%_N_I0pt4" => [0.052395,0.051907,0.10806],
      "Tnt_50%_N_I0pt6" => [0.078593,0.07786,0.10806],
      "Tnt_50%_N_I0pt8" => [0.10479,0.10382,0.10805],
      # 25% VLT
      "Tnt_25%_N_I0" => [0,0,0],
      "Tnt_25%_N_I0pt4" => [0.06382,0.063153,0.12693],
      "Tnt_25%_N_I0pt6" => [0.09572,0.094725,0.12696],
      "Tnt_25%_N_I0pt8" => [0.12764,0.12631,0.12693],
      "Tnt_25%_N_I0_Dark" => [0,0,0],
      "Tnt_25%_N_I0pt4_Dark" => [0.06382,0.063153,0.12693],
      "Tnt_25%_N_I0pt6_Dark" => [0.09572,0.094725,0.12696],
      "Tnt_25%_N_I0pt8_Dark" => [0.12764,0.12631,0.12693],
      "Tnt_25%_N_I0_Light" => [0,0,0],
      "Tnt_25%_N_I0pt4_Light" => [0.0016858,0.001608,0.084473],
      "Tnt_25%_N_I0pt6_Light" => [0.0025286,0.0024119,0.084463],
      "Tnt_25%_N_I0pt8_Light" => [0.0033715,0.0032158,0.084456],
      # 20% VLT
      "Tnt_20%_N_I0_Dark" => [0,0,0],
      "Tnt_20%_N_I0pt4_Dark" => [0.0698,0.069,0.121],
      "Tnt_20%_N_I0pt6_Dark" => [0.105,0.103,0.121],
      "Tnt_20%_N_I0pt8_Dark" => [0.139,0.138,0.121],
      "Tnt_20%_N_I0_Light" => [0,0,0],
      "Tnt_20%_N_I0pt4_Light" => [0.0016858,0.001608,0.084473],
      "Tnt_20%_N_I0pt6_Light" => [0.0025286,0.0024119,0.084463],
      "Tnt_20%_N_I0pt8_Light" => [0.0033715,0.0032158,0.084456],
      # 15% VLT
      "Tnt_15%_N_I0_Dark" => [0,0,0],
      "Tnt_15%_N_I0pt4_Dark" => [0.076,0.075,0.118],
      "Tnt_15%_N_I0pt6_Dark" => [0.113,0.113,0.118],
      "Tnt_15%_N_I0pt8_Dark" => [0.151,0.15,0.118],
      "Tnt_15%_N_I0_Light" => [0,0,0],
      "Tnt_15%_N_I0pt4_Light" => [0.0016858,0.001608,0.084473],
      "Tnt_15%_N_I0pt6_Light" => [0.0025286,0.0024119,0.084463],
      "Tnt_15%_N_I0pt8_Light" => [0.0033715,0.0032158,0.084456],
      # 10% VLT
      "Tnt_10%_N_I0_Dark" => [0,0,0],
      "Tnt_10%_N_I0pt4_Dark" => [0.082,0.082,0.115],
      "Tnt_10%_N_I0pt6_Dark" => [0.123,0.123,0.115],
      "Tnt_10%_N_I0pt8_Dark" => [0.165,0.163,0.115],
      "Tnt_10%_N_I0_Light" => [0,0,0],
      "Tnt_10%_N_I0pt4_Light" => [0.0016858,0.001608,0.084473],
      "Tnt_10%_N_I0pt6_Light" => [0.0025286,0.0024119,0.084463],
      "Tnt_10%_N_I0pt8_Light" => [0.0033715,0.0032158,0.084456],
      # 5% VLT
      "Tnt_5%_N_I0_Dark" => [0,0,0],
      "Tnt_5%_N_I0pt4_Dark" => [0.090521,0.089666,0.10816],
      "Tnt_5%_N_I0pt6_Dark" => [0.13578,0.1345,0.10816],
      "Tnt_5%_N_I0pt8_Dark" => [0.18094,0.17925,0.10828],
      "Tnt_5%_N_I0_Light" => [0,0,0],
      "Tnt_5%_N_I0pt4_Light" => [0.0016858,0.001608,0.084473],
      "Tnt_5%_N_I0pt6_Light" => [0.0025286,0.0024119,0.084463],
      "Tnt_5%_N_I0pt8_Light" => [0.0033715,0.0032158,0.084456],
      # 0.5% VLT
      "Tnt_0pt5%_N_I0_Dark" => [0,0,0],
      "Tnt_0pt5%_N_I0pt4_Dark" => [0.1015,0.10032,0.10089],
      "Tnt_0pt5%_N_I0pt6_Dark" => [0.15226,0.15048,0.10089],
      "Tnt_0pt5%_N_I0pt8_Dark" => [0.20301,0.20064,0.10089],
      "Tnt_0pt5%_N_I0_Light" => [0,0,0],
      "Tnt_0pt5%_N_I0pt4_Light" => [0.0023416,0.0022699,0.092563],
      "Tnt_0pt5%_N_I0pt6_Light" => [0.0035124,0.0034048,0.092562],
      "Tnt_0pt5%_N_I0pt8_Light" => [0.0046832,0.0045397,0.092561],
      # Triple 5% VLT
      "Tr_5%_N_I0_Dark" => [0,0,0],
      "Tr_5%_N_I0pt4_Dark" => [0.090521,0.089666,0.10816],
      "Tr_5%_N_I0pt6_Dark" => [0.13578,0.1345,0.10816],
      "Tr_5%_N_I0pt8_Dark" => [0.18094,0.17925,0.10828],
      "Tr_5%_N_I0_Light" => [0,0,0],
      "Tr_5%_N_I0pt4_Light" => [0.0016858,0.001608,0.084473],
      "Tr_5%_N_I0pt6_Light" => [0.0025286,0.0024119,0.084463],
      "Tr_5%_N_I0pt8_Light" => [0.0033715,0.0032158,0.084456],
      # Triple 0.5% VLT
      "Tr_0pt5%_N_I0_Dark" => [0,0,0],
      "Tr_0pt5%_N_I0pt4_Dark" => [0.1015,0.10032,0.10089],
      "Tr_0pt5%_N_I0pt6_Dark" => [0.15226,0.15048,0.10089],
      "Tr_0pt5%_N_I0pt8_Dark" => [0.20301,0.20064,0.10089],
      "Tr_0pt5%_N_I0_Light" => [0,0,0],
      "Tr_0pt5%_N_I0pt4_Light" => [0.0023416,0.0022699,0.092563],
      "Tr_0pt5%_N_I0pt6_Light" => [0.0035124,0.0034048,0.092562],
      "Tr_0pt5%_N_I0pt8_Light" => [0.0046832,0.0045397,0.092561],
      # VIG 5% VLT
      "V_5%_N_I0_Dark" => [0,0,0],
      "V_5%_N_I0pt4_Dark" => [0.090521,0.089666,0.10816],
      "V_5%_N_I0pt6_Dark" => [0.13578,0.1345,0.10816],
      "V_5%_N_I0pt8_Dark" => [0.18094,0.17925,0.10828],
      "V_5%_N_I0_Light" => [0,0,0],
      "V_5%_N_I0pt4_Light" => [0.0016858,0.001608,0.084473],
      "V_5%_N_I0pt6_Light" => [0.0025286,0.0024119,0.084463],
      "V_5%_N_I0pt8_Light" => [0.0033715,0.0032158,0.084456],
      # VIG 0.5% VLT
      "V_0pt5%_N_I0_Dark" => [0,0,0],
      "V_0pt5%_N_I0pt4_Dark" => [0.1015,0.10032,0.10089],
      "V_0pt5%_N_I0pt6_Dark" => [0.15226,0.15048,0.10089],
      "V_0pt5%_N_I0pt8_Dark" => [0.20301,0.20064,0.10089],
      "V_0pt5%_N_I0_Light" => [0,0,0],
      "V_0pt5%_N_I0pt4_Light" => [0.0023416,0.0022699,0.092563],
      "V_0pt5%_N_I0pt6_Light" => [0.0035124,0.0034048,0.092562],
      "V_0pt5%_N_I0pt8_Light" => [0.0046832,0.0045397,0.092561],
      # Triple 50% VLT
      "Tr_50%_S_I0" => [0,0,0],
      "Tr_50%_S_I0pt4" => [0.063462,0.062819,0.13557],
      "Tr_50%_S_I0pt6" => [0.095248,0.094249,0.13539],
      "Tr_50%_S_I0pt8" => [0.127,0.12567,0.13539],
      "Tr_50%_N_I0" => [0,0,0],
      "Tr_50%_N_I0pt4" => [0.052395,0.051907,0.10806],
      "Tr_50%_N_I0pt6" => [0.078593,0.07786,0.10806],
      "Tr_50%_N_I0pt8" => [0.10479,0.10382,0.10805],
      # Triple 25% VLT
      "Tr_25%_N_I0" => [0,0,0],
      "Tr_25%_N_I0pt4" => [0.06382,0.063153,0.12693],
      "Tr_25%_N_I0pt6" => [0.09572,0.094725,0.12696],
      "Tr_25%_N_I0pt8" => [0.12764,0.12631,0.12693],
      # VIG 50% VLT
      "V_50%_S_I0" => [0,0,0],
      "V_50%_S_I0pt4" => [0.063462,0.062819,0.13557],
      "V_50%_S_I0pt6" => [0.095248,0.094249,0.13539],
      "V_50%_S_I0pt8" => [0.127,0.12567,0.13539],
      "V_50%_N_I0" => [0,0,0],
      "V_50%_N_I0pt4" => [0.052395,0.051907,0.10806],
      "V_50%_N_I0pt6" => [0.078593,0.07786,0.10806],
      "V_50%_N_I0pt8" => [0.10479,0.10382,0.10805],
      # VIG 25% VLT
      "V_25%_N_I0" => [0,0,0],
      "V_25%_N_I0pt4" => [0.06382,0.063153,0.12693],
      "V_25%_N_I0pt6" => [0.09572,0.094725,0.12696],
      "V_25%_N_I0pt8" => [0.12764,0.12631,0.12693],
      # standard
      "standard" => [0.20647,0.204,0.104],
    }

    if (use_tint_iqe == true)
      if (bipv_type == "BIPV on transparent (window) facade") || (bipv_type == "BIPV on all facade")
        if (switching_scenario=="Static")
          runner.registerInfo("### DEBUGGING: Checking if PCE regression model coefficients are available with selected IQE Type #{iqe_transparent}: #{dictionary_iqe_pce[iqe_transparent]}") if (debug_mode == true)
          if (dictionary_iqe_pce[iqe_transparent].nil?)
            runner.registerWarning("Dynamic power conversion cannot be applied. Selected IQE Type does not have (hard coded) regression model. BIPV not implemented. Exiting...")
            return false
          end
        elsif (switching_scenario=="Thermochromic")
          runner.registerInfo("### DEBUGGING: Checking if PCE regression model coefficients are available with selected IGU Type  #{iqe_transparent} (light state): #{dictionary_iqe_pce[iqe_transparent+"_Dark"]}") if (debug_mode == true)
          runner.registerInfo("### DEBUGGING: Checking if PCE regression model coefficients are available with selected IGU Type  #{iqe_transparent} (dark state): #{dictionary_iqe_pce[iqe_transparent+"_Light"]}") if (debug_mode == true)
          if (dictionary_iqe_pce[iqe_transparent+"_Dark"].nil?)||(dictionary_iqe_pce[iqe_transparent+"_Light"].nil?)
            runner.registerWarning("Dynamic power conversion cannot be applied. Selected IGU Type does not have (hard coded) regression model. BIPV not implemented. Exiting...")
            return false
          end
        end
      elsif (bipv_type == "BIPV on opaque (wall) facade") || (bipv_type == "BIPV on all facade")
        runner.registerInfo("### DEBUGGING: Checking if PCE regression model coefficients are available with selected IQE Type #{iqe_opaque}: #{dictionary_iqe_pce[iqe_opaque]}") if (debug_mode == true)
        if (dictionary_iqe_pce[iqe_opaque].nil?)
          runner.registerWarning("Dynamic power conversion cannot be applied. Selected IQE Type does not have (hard coded) regression model. BIPV not implemented. Exiting...")
          return false
        end
      end
    end

    ##########################################################################
    # skip PV implementation if PV orientation is selected as NONE
    ##########################################################################
    if pv_orientation == "NONE"
      runner.registerInfo("PV orientation is selected with NONE. Thus, no PV. Exiting...")
      return false
    end

    ##########################################################################
    # get the windows
    ##########################################################################
    ext_windows = []
    ext_windows_name = []
    model.getSubSurfaces.each do |s|
      ext_windows << s if s.subSurfaceType == "FixedWindow" && s.outsideBoundaryCondition == "Outdoors"
    end

    ##########################################################################
    # get the exterior walls
    ##########################################################################
    ext_walls = []
    ext_walls_name = []
    model.getSurfaces.each do |s|
      ext_walls << s if s.surfaceType == "Wall" && s.outsideBoundaryCondition == "Outdoors"
    end

    ##########################################################################
    # report initial condition
    ##########################################################################
    if bipv_type == "BIPV on transparent (window) facade"
      runner.registerInfo("Option selected for PVs only on transparent (window) façade")
      runner.registerInitialCondition("Input building contains #{ext_windows.size.to_s} exterior window surfaces.")
    elsif bipv_type == "BIPV on opaque (wall) facade"
      runner.registerInfo("Option selected for PVs only on opaque (exterior wall) façade")
      runner.registerInitialCondition("Input building contains #{ext_walls.size.to_s} exterior wall surfaces.")
    elsif bipv_type == "BIPV on all facade"
      runner.registerInfo("Option selected for PVs on both transparent (window) and opaque (exterior wall) façade")
      runner.registerInitialCondition("Input building contains #{ext_windows.size.to_s} exterior window surfaces and #{ext_walls.size.to_s} exterior wall surfaces.")
    end

    ##########################################################################
    # get surfaces based on cardinal direction setting
    # WARNING
    # this only works when there is one window on one wall
    # maybe it'll be better to start with wall searching and then window
    ##########################################################################
    # find candidate windows
    candidate_windows = []
    candidate_walls = []
    ext_windows.each do |s|
      azimuth = OpenStudio::Quantity.new(s.azimuth,OpenStudio::createSIAngle)
      azimuth = OpenStudio::convert(azimuth,OpenStudio::createIPAngle).get.value
      if pv_orientation == "ALL"
        candidate_windows << s
        ext_windows_name << s.name.to_s
        next
      end
      candidate_windows << s if (azimuth >= 315.0 or azimuth < 45.0) && pv_orientation == 'N'
      candidate_windows << s if (azimuth >= 45.0 and azimuth < 135.0) && pv_orientation == 'E'
      candidate_windows << s if (azimuth >= 135.0 and azimuth < 225.0) && pv_orientation == 'S'
      candidate_windows << s if (azimuth >= 225.0 and azimuth < 315.0) && pv_orientation == 'W'
      candidate_windows << s if (azimuth >= 45.0 and azimuth < 315.0) && pv_orientation == 'ESW'
      ext_windows_name << s.name.to_s if (azimuth >= 315.0 or azimuth < 45.0) && pv_orientation == 'N'
      ext_windows_name << s.name.to_s if (azimuth >= 45.0 and azimuth < 135.0) && pv_orientation == 'E'
      ext_windows_name << s.name.to_s if (azimuth >= 135.0 and azimuth < 225.0) && pv_orientation == 'S'
      ext_windows_name << s.name.to_s if (azimuth >= 225.0 and azimuth < 315.0) && pv_orientation == 'W'
      ext_windows_name << s.name.to_s if (azimuth >= 45.0 and azimuth < 315.0) && pv_orientation == 'ESW'
    end
    runner.registerInfo("#{candidate_windows.size.to_s} window(s) meet PV orientation selection criteria (PV orientation = '#{pv_orientation}')") if (bipv_type != "BIPV on opaque (wall) facade")
    runner.registerInfo("### DEBUGGING: Surface names affected = #{ext_windows_name}") if (bipv_type != "BIPV on opaque (wall) facade") && (debug_mode == true)

    # find candidate walls associated with selected windows
    candidate_windows.each do |window|
      runner.registerInfo("### DEBUGGING: associated wall name (#{window.surface().get.name}) for window (#{window.name})") if (debug_mode == true)
      candidate_walls << window.surface().get
      ext_walls_name << window.surface().get.name.get
    end
    runner.registerInfo("#{candidate_walls.size.to_s} exterior wall(s) meet PV orientation selection criteria (PV orientation = '#{pv_orientation}')") if (bipv_type != "BIPV on transparent (window) facade")
    runner.registerInfo("### DEBUGGING: Surface names affected = #{ext_walls_name}") if (bipv_type != "BIPV on transparent (window) facade") && (debug_mode == true)


    ##########################################################################
    # create the inverter
    ##########################################################################
    inverter = OpenStudio::Model::ElectricLoadCenterInverterSimple.new(model)
    inverter.setInverterEfficiency(inverter_eff)
    runner.registerInfo("Created inverter with efficiency of #{inverter.inverterEfficiency}")

    ##########################################################################
    # create the distribution system
    ##########################################################################
    elcd = OpenStudio::Model::ElectricLoadCenterDistribution.new(model)
    elcd.setInverter(inverter)
    elcd.setName('UbiQD - Distribution')

    ##########################################################################
    # adding PV surface
    ##########################################################################
    pv_area_total = 0.0
    system_rated_output = 0.0
    candidate_windows.zip(candidate_walls).each do |surface_window, surface_wall|

      runner.registerInfo("### DEBUGGING: adding virtual PV surface(s) on #{surface_window.name} (window) and #{surface_wall.name} (wall).") if (debug_mode == true)

      #-----------------------------------------------------
      # make single shading surface group for each window
      #-----------------------------------------------------
      shading_surface_group_window = OpenStudio::Model::ShadingSurfaceGroup.new(model)
      shading_surface_group_wall_upper = OpenStudio::Model::ShadingSurfaceGroup.new(model)
      shading_surface_group_wall_lower = OpenStudio::Model::ShadingSurfaceGroup.new(model)

      #-----------------------------------------------------
      # set the space on the shading group
      #-----------------------------------------------------
      shading_surface_group_window.setSpace(surface_window.space.get) if surface_window.space.is_initialized

      #-----------------------------------------------------
      # set vector for transforming window/wall surface to PV surface
      #-----------------------------------------------------
      vec = surface_window.outwardNormal
      #vec = vec
      vec.setLength(0.0254) # PV surface projection in meters

      #-----------------------------------------------------
      # get window points and project along window normal
      #-----------------------------------------------------
      vertices_window = surface_window.vertices
      vertices_wall = surface_wall.vertices

      transform_window = OpenStudio::Transformation.new
      transform_window = surface_window.space.get.transformation if surface_window.space.is_initialized
      transform_wall = OpenStudio::Transformation.new
      transform_wall = surface_wall.space.get.transformation if surface_wall.space.is_initialized

      #-----------------------------------------------------
      # transform to world coords
      #-----------------------------------------------------
      vertices_window = transform_window * vertices_window
      vertices_wall = transform_wall * vertices_wall

      points_windows = []
      points_walls_upper = []
      points_walls_lower = []
      height_adjustments = []

      #-----------------------------------------------------
      # create vertices for windows
      #-----------------------------------------------------
      vertices_window.each do |f|
        runner.registerInfo("### DEBUGGING: For window surface (#{surface_window.name}): window vertex #{f} -> projected PV vertex #{f + vec}") if (debug_mode == true)
        pp = f + vec
        # add projected PV surface from window surface to points variable if necessary
        if (bipv_type == "BIPV on transparent (window) facade") || (bipv_type == "BIPV on all facade")
          points_windows << pp
        end
        height_adjustments << pp.z
      end

      #-----------------------------------------------------
      # create vertices for walls (upper & lower)
      # WARNING!!!!
      # this part is mostly a limitation (hard-coded)
      # since it'll only work if there is one window per one wall
      # and window width is almost the same as wall width
      #      -------------------------------------
      #      |               wall                |
      #      |                                   |
      #      | --------------------------------- |
      #      | |                               | |
      #      | |            window             | |
      #      | |                               | |
      #      | --------------------------------- |
      #      |                                   |
      #      |                                   | 
      #      ------------------------------------- 
      #-----------------------------------------------------
      if bipv_type != "BIPV on transparent (window) facade"
        count=0
        vertices_wall.each do |f|
          runner.registerInfo("### DEBUGGING: For wall surface (#{surface_wall.name}): wall vertex #{f} -> projected PV vertex #{f + vec}") if (debug_mode == true)
          pp = f + vec
          pp_x = pp.x
          pp_y = pp.y
          if count == 0
            pp_upper = pp
            pp_lower = OpenStudio::Point3d.new(pp_x,pp_y,height_adjustments[1])
            runner.registerInfo("### DEBUGGING: pp_upper = #{pp_upper}") if (debug_mode == true)
            runner.registerInfo("### DEBUGGING: pp_lower = #{pp_lower}") if (debug_mode == true)
          elsif count==1
            pp_upper = OpenStudio::Point3d.new(pp_x,pp_y,height_adjustments[0])
            pp_lower = pp
            runner.registerInfo("### DEBUGGING: pp_upper = #{pp_upper}") if (debug_mode == true)
            runner.registerInfo("### DEBUGGING: pp_lower = #{pp_lower}") if (debug_mode == true)
          elsif count==2
            pp_upper = OpenStudio::Point3d.new(pp_x,pp_y,height_adjustments[0])
            pp_lower = pp
            runner.registerInfo("### DEBUGGING: pp_upper = #{pp_upper}") if (debug_mode == true)
            runner.registerInfo("### DEBUGGING: pp_lower = #{pp_lower}") if (debug_mode == true)
          elsif count==3
            pp_upper = pp
            pp_lower = OpenStudio::Point3d.new(pp_x,pp_y,height_adjustments[1])
            runner.registerInfo("### DEBUGGING: pp_upper = #{pp_upper}") if (debug_mode == true)
            runner.registerInfo("### DEBUGGING: pp_lower = #{pp_lower}") if (debug_mode == true)
          end
          # add projected PV surfaces from window surfaces to points variable if necessary
          points_walls_upper << pp_upper
          points_walls_lower << pp_lower
          count+=1
        end
      end

      if (bipv_type == "BIPV on transparent (window) facade") & (points_windows.size == 0)
        runner.registerInfo("No PV surfaces are defined for windows. Exiting...")
        return false
      elsif (bipv_type == "BIPV on opaque (wall) facade") & (points_walls_upper.size == 0) & (points_walls_upper.size == 0)
        runner.registerInfo("No PV surfaces are defined for walls. Exiting...")
        return false
      else
        points_windows = transform_window.inverse * points_windows # send back to space coords
        points_walls_upper = transform_wall.inverse * points_walls_upper # send back to space coords
        points_walls_lower = transform_wall.inverse * points_walls_lower # send back to space coords
      end

      #-----------------------------------------------------
      # mounting PV based on PV vertivies information
      #-----------------------------------------------------
      # setting list of objects based on BIPV type to mount PV surfaces
      if (bipv_type == "BIPV on transparent (window) facade")
        list_points = [points_windows]
        list_labels = ["window"]
      elsif (bipv_type == "BIPV on opaque (wall) facade") 
        list_points = [points_walls_upper, points_walls_lower]
        list_labels = ["wall (upper)", "wall (lower)"]
      elsif (bipv_type == "BIPV on all facade")
        list_points = [points_windows, points_walls_upper, points_walls_lower]
        list_labels = ["window", "wall (upper)", "wall (lower)"]
      end
       
      # adding PV surface and configuration for each surface
      i=1
      list_points.zip(list_labels).each do |points, label|

        runner.registerInfo("------------------------------------------------------------------------------------")
        # setting transmittance for opaque/transparent/all scenarios
        if label == "window"
          target_transmittance = 1.0
          surface_reference = surface_window
          pv_eff = pv_eff_trnpt
          key = iqe_transparent
        elsif (label == "wall (upper)") || (label == "wall (lower)")
          target_transmittance = 0.0
          surface_reference = surface_wall
          pv_eff = pv_eff_opq
          key = iqe_opaque
        end
        runner.registerInfo("Adding PV surface to #{surface_reference.name} - #{label}.")
        inputs = {
            'name' => "PV Shading Transmittance Schedule Transparent",
            'winterTimeValuePairs' => { 24.0 => target_transmittance },
            'summerTimeValuePairs' => { 24.0 => target_transmittance },
            'defaultTimeValuePairs' => { 24.0 => target_transmittance }
        }
        shading_surface_transmittance_schedule = OsLib_Schedules.createSimpleSchedule(model,inputs)
        runner.registerInfo("Setting transmittance of virtual PV surface #{i} to #{target_transmittance}.")

        # simplifying label name for defining unique surface names for each PV surface
        label = label.gsub("(", "").gsub(")", "").gsub(" ", "").downcase
        surface_name_updated = (surface_reference.name.to_s.gsub(" ", "_") + "_" + label).downcase
      
        shading_surface = OpenStudio::Model::ShadingSurface.new(points, model)
        pv_area = OpenStudio::getArea(shading_surface.vertices()).get
        pv_area_total += pv_area
        pv_area_ip = OpenStudio.convert(pv_area, "m^2", "ft^2")
        shading_surface.setShadingSurfaceGroup(shading_surface_group_window)
        shading_surface.setName("PV - #{surface_name_updated}")
        shading_surface.setTransmittanceSchedule(shading_surface_transmittance_schedule)
        panel = OpenStudio::Model::GeneratorPhotovoltaic::simple(model)
        panel.setSurface(shading_surface)

        runner.registerInfo("### DEBUGGING: Added PV panel area: #{pv_area.round(2)} m^2 (#{pv_area_ip} ft^2)") if (debug_mode == true)
        panel_output = panel_rated_output * pv_area
        runner.registerInfo("### DEBUGGING: Added PV panel output: #{panel_output.round(1)} W (#{pv_area} m^2)") if (debug_mode == true)

        panel.setRatedElectricPowerOutput(panel_output)
      
        simplepv = panel.photovoltaicPerformance.to_PhotovoltaicPerformanceSimple.get
        simplepv.setFractionOfSurfaceAreaWithActiveSolarCells(dot_coverage)
        
        #-----------------------------------------------------
        # implement power conversion efficiency scenarios
        #-----------------------------------------------------            
        if (label == "window") && (switching_scenario == "Thermochromic") && (use_tint_iqe == "false")
        
          pce_sch = OpenStudio::Model::ScheduleConstant.new(model)
          pce_sch.setName("PCE_SCH_#{surface_name_updated}")
          pce_sch.setValue(0.05)
          runner.registerInfo("Created new Schedule:Constant object (#{pce_sch.name}) representing constant power conversion efficiency.") 
      
          simplepv.setEfficiencySchedule(pce_sch)
      
          runner.registerInfo("Simple PV object name = #{simplepv.name}")
          runner.registerInfo("Associated surface name = #{surface_name_updated}")
          runner.registerInfo("Associated schedule name = #{pce_sch.name}")
        
          # Create new EnergyManagementSystem:Sensor object
          temperature_reference = OpenStudio::Model::EnergyManagementSystemSensor.new(model, "Surface Window Thermochromic Layer Property Specification Temperature")
          temperature_reference.setName("t_#{surface_name_updated}")
          temperature_reference.setKeyName(surface_reference.name.to_s)
          runner.registerInfo("EMS Sensor named #{temperature_reference.name} measuring the reference temperature on #{surface_reference.name.to_s} added to the model.")
      
          # Create EMS Actuator Objects
          pce_sch_actuator = OpenStudio::Model::EnergyManagementSystemActuator.new(pce_sch,"Schedule:Constant","Schedule Value")
          pce_sch_actuator.setName("pce_sch_#{surface_name_updated}")
          runner.registerInfo("EMS Actuator object named '#{pce_sch_actuator.name}' representing the temporary schedule to #{surface_reference.name.to_s} added to the model.") 
        
          # Create new EnergyManagementSystem:Program object
          ems_pce_prg = OpenStudio::Model::EnergyManagementSystemProgram.new(model)
          ems_pce_prg.setName("program_pce_#{surface_name_updated}")
          ems_pce_prg.addLine("SET T_ref_#{surface_name_updated} = #{temperature_reference.name.to_s}")
          ems_pce_prg.addLine("IF (T_ref_#{surface_name_updated} < #{switch_t})")
          ems_pce_prg.addLine("SET #{pce_sch.name} = #{pv_eff_light}")
          ems_pce_prg.addLine("ELSEIF (T_ref_#{surface_name_updated} >= #{switch_t})") 
          ems_pce_prg.addLine("SET #{pce_sch.name} = #{pv_eff_dark}")
          ems_pce_prg.addLine("ENDIF") 
          runner.registerInfo("EMS Program object named '#{ems_pce_prg.name}' added to modify the PCE schedule on #{surface_reference.name.to_s}.")
        
          # create new EnergyManagementSystem:ProgramCallingManager object 
          ems_prgm_calling_mngr = OpenStudio::Model::EnergyManagementSystemProgramCallingManager.new(model)
          ems_prgm_calling_mngr.setName("callingmanager_pce_#{surface_name_updated}")
          ems_prgm_calling_mngr.setCallingPoint("BeginTimestepBeforePredictor")
          ems_prgm_calling_mngr.addProgram(ems_pce_prg)
          runner.registerInfo("EMS Program Calling Manager object named '#{ems_prgm_calling_mngr.name}' added to call #{ems_pce_prg.name} EMS program.")
          
          runner.registerInfo("Power conversion efficiency of #{pv_eff_light} applied to #{simplepv.name.to_s} for light state")
          runner.registerInfo("Power conversion efficiency of #{pv_eff_dark} applied to #{simplepv.name.to_s} for dark state")
          
        elsif (label == "window") && (switching_scenario == "Thermochromic") && (use_tint_iqe == "true")
                
          pce_sch = OpenStudio::Model::ScheduleConstant.new(model)
          pce_sch.setName("PCE_SCH_#{surface_name_updated}")
          pce_sch.setValue(0.05)
          runner.registerInfo("Created new Schedule:Constant object (#{pce_sch.name}) representing constant power conversion efficiency.") 
      
          simplepv.setEfficiencySchedule(pce_sch)
      
          runner.registerInfo("Simple PV object name = #{simplepv.name}")
          runner.registerInfo("Associated surface name = #{surface_name_updated}")
          runner.registerInfo("Associated schedule name = #{pce_sch.name}")
        
          # Create new EnergyManagementSystem:Sensor object
          temperature_reference = OpenStudio::Model::EnergyManagementSystemSensor.new(model, "Surface Window Thermochromic Layer Property Specification Temperature")
          temperature_reference.setName("t_#{surface_name_updated}")
          temperature_reference.setKeyName(surface_reference.name.to_s)
          runner.registerInfo("EMS Sensor named #{temperature_reference.name} measuring the reference temperature on #{surface_reference.name.to_s} added to the model.")
          
          incident_angle = OpenStudio::Model::EnergyManagementSystemSensor.new(model, "Surface Outside Face Beam Solar Incident Angle Cosine Value")
          incident_angle.setName("a_#{surface_name_updated}")
          incident_angle.setKeyName(surface_reference.name.to_s)
          runner.registerInfo("EMS Sensor named #{incident_angle.name} measuring the solar incident angle on #{surface_reference.name.to_s} added to the model.")
      
          # Create EMS Actuator Objects
          pce_sch_actuator = OpenStudio::Model::EnergyManagementSystemActuator.new(pce_sch,"Schedule:Constant","Schedule Value")
          pce_sch_actuator.setName("pce_sch_#{surface_name_updated}")
          runner.registerInfo("EMS Actuator object named '#{pce_sch_actuator.name}' representing the temporary schedule to #{surface_reference.name.to_s} added to the model.")       

          # Create new EnergyManagementSystem:Program object 
          runner.registerInfo("EMS Program being created to simulate PCE variation for #{key}") 
          ems_pce_prg = OpenStudio::Model::EnergyManagementSystemProgram.new(model)
          ems_pce_prg.setName("program_pce_#{surface_name_updated}")
          ems_pce_prg.addLine("SET a_deg_#{surface_name_updated} = (@ArcCos a_#{surface_name_updated})*180/PI")
          ems_pce_prg.addLine("SET T_ref_#{surface_name_updated} = #{temperature_reference.name.to_s}")
          ems_pce_prg.addLine("IF (T_ref_#{surface_name_updated} < #{switch_t})")
          ems_pce_prg.addLine("IF (a_deg_#{surface_name_updated} == 90)")
          ems_pce_prg.addLine("SET #{pce_sch.name} = 0")
          ems_pce_prg.addLine("ELSEIF (a_deg_#{surface_name_updated} > 90)")
          ems_pce_prg.addLine("SET #{pce_sch.name} = 0")
          ems_pce_prg.addLine("ELSE")
          ems_pce_prg.addLine("SET expterm_l_#{surface_name_updated} = #{dictionary_iqe_pce[key+"_Light"][2]}*(a_deg_#{surface_name_updated}-90)")
          ems_pce_prg.addLine("SET #{pce_sch.name} = #{dictionary_iqe_pce[key+"_Light"][0]}-#{dictionary_iqe_pce[key+"_Light"][1]}*(@EXP expterm_l_#{surface_name_updated})")
          ems_pce_prg.addLine("ENDIF")
          ems_pce_prg.addLine("ELSEIF (T_ref_#{surface_name_updated} >= #{switch_t})") 
          ems_pce_prg.addLine("IF (a_deg_#{surface_name_updated} == 90)")
          ems_pce_prg.addLine("SET #{pce_sch.name} = 0")
          ems_pce_prg.addLine("ELSEIF (a_deg_#{surface_name_updated} > 90)")
          ems_pce_prg.addLine("SET #{pce_sch.name} = 0")
          ems_pce_prg.addLine("ELSE")
          ems_pce_prg.addLine("SET expterm_d_#{surface_name_updated} = #{dictionary_iqe_pce[key+"_Dark"][2]}*(a_deg_#{surface_name_updated}-90)")
          ems_pce_prg.addLine("SET #{pce_sch.name} = #{dictionary_iqe_pce[key+"_Dark"][0]}-#{dictionary_iqe_pce[key+"_Dark"][1]}*(@EXP expterm_d_#{surface_name_updated})")
          ems_pce_prg.addLine("ENDIF")
          ems_pce_prg.addLine("ENDIF") 
          runner.registerInfo("EMS Program object named '#{ems_pce_prg.name}' added to modify the PCE schedule on #{surface_reference.name.to_s}.")
        
          # create new EnergyManagementSystem:ProgramCallingManager object 
          ems_prgm_calling_mngr = OpenStudio::Model::EnergyManagementSystemProgramCallingManager.new(model)
          ems_prgm_calling_mngr.setName("callingmanager_pce_#{surface_name_updated}")
          ems_prgm_calling_mngr.setCallingPoint("BeginTimestepBeforePredictor")
          ems_prgm_calling_mngr.addProgram(ems_pce_prg)
          runner.registerInfo("EMS Program Calling Manager object named '#{ems_prgm_calling_mngr.name}' added to call #{ems_pce_prg.name} EMS program.") 
          
          # Create new EnergyManagementSystem:GlobalVariable object 
          dynamic_pce = OpenStudio::Model::EnergyManagementSystemGlobalVariable.new(model, "dynamic_pce_#{surface_name_updated}")
        
          # Create new EMS Output Variable Object
          ems_output_var = OpenStudio::Model::EnergyManagementSystemOutputVariable.new(model,dynamic_pce)
          ems_output_var.setName("dynamic_pce_#{surface_name_updated}")
          ems_output_var.setEMSVariableName("#{pce_sch.name}")
          ems_output_var.setTypeOfDataInVariable("Averaged")
          ems_output_var.setUpdateFrequency("SystemTimeStep")
    
          runner.registerInfo("Power conversion efficiency coefficient set of #{dictionary_iqe_pce[key+"_Light"]} applied to #{simplepv.name.to_s} for light state")
          runner.registerInfo("Power conversion efficiency coefficient set of #{dictionary_iqe_pce[key+"_Dark"]} applied to #{simplepv.name.to_s} for dark state")
          
        elsif (switching_scenario == "Static") && (use_tint_iqe == "false")
        
          simplepv.setFixedEfficiency(pv_eff)
          runner.registerInfo("Constant power conversion efficiency of #{pv_eff} applied to #{simplepv.name.to_s}")
          
        elsif (label == "window") && (switching_scenario == "Thermochromic") && (use_tint_iqe == "false")
        
          simplepv.setFixedEfficiency(dictionary_iqe_pce[key])
          runner.registerInfo("Constant power conversion efficiency of #{dictionary_iqe_pce[key]} applied to #{simplepv.name.to_s}")
          
        elsif ((label == "window") && (switching_scenario == "Static") && (use_tint_iqe == "true")) || ((label != "window") && (use_tint_iqe == "true"))
        
          pce_sch = OpenStudio::Model::ScheduleConstant.new(model)
          pce_sch.setName("PCE_SCH_#{surface_name_updated}")
          pce_sch.setValue(0.05)
          runner.registerInfo("Created new Schedule:Constant object (#{pce_sch.name}) representing constant power conversion efficiency.") 
      
          simplepv.setEfficiencySchedule(pce_sch)
      
          runner.registerInfo("Simple PV object name = #{simplepv.name}")
          runner.registerInfo("Associated surface name = #{surface_name_updated}")
          runner.registerInfo("Associated schedule name = #{pce_sch.name}")
        
          # Create new EnergyManagementSystem:Sensor object        
          incident_angle = OpenStudio::Model::EnergyManagementSystemSensor.new(model, "Surface Outside Face Beam Solar Incident Angle Cosine Value")
          incident_angle.setName("a_#{surface_name_updated}")
          incident_angle.setKeyName(surface_reference.name.to_s)
          runner.registerInfo("EMS Sensor named #{incident_angle.name} measuring the solar incident angle on #{surface_reference.name.to_s} added to the model.")
      
          # Create EMS Actuator Objects
          pce_sch_actuator = OpenStudio::Model::EnergyManagementSystemActuator.new(pce_sch,"Schedule:Constant","Schedule Value")
          pce_sch_actuator.setName("pce_sch_#{surface_name_updated}")
          runner.registerInfo("EMS Actuator object named '#{pce_sch_actuator.name}' representing the temporary schedule to #{surface_reference.name.to_s} added to the model.")       
        
          # Create new EnergyManagementSystem:Program object
          runner.registerInfo("EMS Program being created to simulate PCE variation for #{key}")
          ems_pce_prg = OpenStudio::Model::EnergyManagementSystemProgram.new(model)
          ems_pce_prg.setName("program_pce_#{surface_name_updated}")
          ems_pce_prg.addLine("SET a_deg_#{surface_name_updated} = (@ArcCos a_#{surface_name_updated})*180/PI")
          ems_pce_prg.addLine("IF (a_deg_#{surface_name_updated} == 90)")
          ems_pce_prg.addLine("SET #{pce_sch.name} = 0")
          ems_pce_prg.addLine("ELSEIF (a_deg_#{surface_name_updated} > 90)")
          ems_pce_prg.addLine("SET #{pce_sch.name} = 0")
          ems_pce_prg.addLine("ELSE")
          ems_pce_prg.addLine("SET expterm_l_#{surface_name_updated} = #{dictionary_iqe_pce[key][2]}*(a_deg_#{surface_name_updated}-90)")
          ems_pce_prg.addLine("SET #{pce_sch.name} = #{dictionary_iqe_pce[key][0]}-#{dictionary_iqe_pce[key][1]}*(@EXP expterm_l_#{surface_name_updated})")
          ems_pce_prg.addLine("ENDIF") 
          runner.registerInfo("EMS Program object named '#{ems_pce_prg.name}' added to modify the PCE schedule on #{surface_reference.name.to_s}.")
        
          # create new EnergyManagementSystem:ProgramCallingManager object 
          ems_prgm_calling_mngr = OpenStudio::Model::EnergyManagementSystemProgramCallingManager.new(model)
          ems_prgm_calling_mngr.setName("callingmanager_pce_#{surface_name_updated}")
          ems_prgm_calling_mngr.setCallingPoint("BeginTimestepBeforePredictor")
          ems_prgm_calling_mngr.addProgram(ems_pce_prg)
          runner.registerInfo("EMS Program Calling Manager object named '#{ems_prgm_calling_mngr.name}' added to call #{ems_pce_prg.name} EMS program.") 
          
          # Create new EnergyManagementSystem:GlobalVariable object 
          dynamic_pce = OpenStudio::Model::EnergyManagementSystemGlobalVariable.new(model, "dynamic_pce_#{surface_name_updated}")
        
          # Create new EMS Output Variable Object
          ems_output_var = OpenStudio::Model::EnergyManagementSystemOutputVariable.new(model,dynamic_pce)
          ems_output_var.setName("dynamic_pce_#{surface_name_updated}")
          ems_output_var.setEMSVariableName("#{pce_sch.name}")
          ems_output_var.setTypeOfDataInVariable("Averaged")
          ems_output_var.setUpdateFrequency("SystemTimeStep")
    
          runner.registerInfo("Power conversion efficiency coefficient set of #{dictionary_iqe_pce[key]} applied to #{simplepv.name.to_s}")
          
        end

        ######################################################
        # connect panel to electric load center distribution
        ######################################################
        elcd.addGenerator(panel)

        i+=1

      end

     end
     runner.registerInfo("------------------------------------------------------------------------------------")

    ######################################################
    # define outputs for server analyses
    ######################################################
    # get num_stories_above_grade and story_multiplier from preceding measure
    # get multiplier method, expecting: ["Basements Ground Mid Top", "none"]
    story_multiplier = OsLib_HelperMethods.check_upstream_measure_for_arg(runner, 'story_multiplier')
    scaled_note = ""
    if story_multiplier[:value] == "Basements Ground Mid Top"
      scaled_note = '(scaled)'
      num_stories_above_grade = OsLib_HelperMethods.check_upstream_measure_for_arg(runner, 'num_stories_above_grade')
      pv_area_total_initial = pv_area_total
      pv_area_total = ((pv_area_total/3) * (num_stories_above_grade[:value].to_f - 2)) + ((pv_area_total/3) * 2)
      runner.registerWarning("### DEBUGGING: Zone multipliers in use (story multiplier method = #{story_multiplier[:value]}).") if (debug_mode == true)
      runner.registerWarning("### DEBUGGING: Scaling PV panel area to account for zone multipliers (initial: #{pv_area_total_initial}, scaled: #{pv_area_total}).") if (debug_mode == true)
    end

    ######################################################
    # convert total to IP units
    ######################################################
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

    runner.registerFinalCondition("#{model.getShadingSurfaces.size} PV surfaces (#{pv_area_total_ip.round(2)} ft^2 total area #{scaled_note}) added to model (PV orientation = '#{pv_orientation}').")

    return true

  end

end

# register the measure to be used by the application
AddThermochromicBIPV.new.registerWithApplication
