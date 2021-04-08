#see the URL below for information on how to write OpenStudio measures
# http://openstudio.nrel.gov/openstudio-measure-writing-guide

#see your EnergyPlus installation or the URL below for information on EnergyPlus objects
# http://apps1.eere.energy.gov/buildings/energyplus/pdfs/inputoutputreference.pdf

#see the URL below for information on using life cycle cost objects in OpenStudio
# http://openstudio.nrel.gov/openstudio-life-cycle-examples

#see the URL below for access to C++ documentation on workspace objects (click on "workspace" in the main window to view workspace objects)
# http://openstudio.nrel.gov/sites/openstudio.nrel.gov/files/nv_data/cpp_documentation_it/utilities/html/idf_page.html

$allchoices = 'All fenestration surfaces'

#start the measure
class AInjectWindowSpecificIDFObjects < OpenStudio::Ruleset::WorkspaceUserScript

  # define the name that a user will see, this method may be deprecated as
  # the display name in PAT comes from the name field in measure.xml
  def name
    return " Inject Window Specific IDF Objects"
  end

  # define the arguments that the user will input
  def arguments(workspace)
    args = OpenStudio::Ruleset::OSArgumentVector.new

    glzsys = OpenStudio::StringVector.new
    glzsys << "======================"
    glzsys << "NEXT Energy Scenarios"
    glzsys << "======================"
    glzsys << "ASHRAE_Simplified"
    glzsys << "Baseline_GlzSys6"
    glzsys << "Baseline_GlzSys13"
    glzsys << "Baseline_GlzSys15"
    glzsys << "Baseline_GlzSys6_13"
    glzsys << "Baseline_GlzSys15_withPV"
    glzsys << "GlzSys_6_withoutPV"
    glzsys << "GlzSys_13_withoutPV"
    glzsys << "GlzSys_6_withPV"
    glzsys << "GlzSys_13_withPV"
    glzsys << "======================"
    glzsys << "ASHRAE_Detailed"
    glzsys << "======================"
    glzsys << "VeryHot_ASHRAE"
    glzsys << "Hot_ASHRAE"
    glzsys << "Cold_ASHRAE"
    glzsys << "VeryCold_ASHRAE"
    glzsys << "======================"
    glzsys << "Tinted"
    glzsys << "======================"
    glzsys << "Tinted_25pct_N"
    glzsys << "======================"
    glzsys << "VeryHot_Tinted_25pct_N_IQE0"
    glzsys << "Hot_Tinted_25pct_N_IQE0"
    glzsys << "Cold_Tinted_25pct_N_IQE0"
    glzsys << "VeryCold_Tinted_25pct_N_IQE0"
    glzsys << "======================"
    glzsys << "VeryHot_Tinted_25pct_N_IQE0pt4"
    glzsys << "Hot_Tinted_25pct_N_IQE0pt4"
    glzsys << "Cold_Tinted_25pct_N_IQE0pt4"
    glzsys << "VeryCold_Tinted_25pct_N_IQE0pt4"
    glzsys << "======================"
    glzsys << "VeryHot_Tinted_25pct_N_IQE0pt6"
    glzsys << "Hot_Tinted_25pct_N_IQE0pt6"
    glzsys << "Cold_Tinted_25pct_N_IQE0pt6"
    glzsys << "VeryCold_Tinted_25pct_N_IQE0pt6"
    glzsys << "======================"
    glzsys << "VeryHot_Tinted_25pct_N_IQE0pt8"
    glzsys << "Hot_Tinted_25pct_N_IQE0pt8"
    glzsys << "Cold_Tinted_25pct_N_IQE0pt8"
    glzsys << "VeryCold_Tinted_25pct_N_IQE0pt8"
    glzsys << "======================"
    glzsys << "Tinted_50pct_N"
    glzsys << "======================"
    glzsys << "VeryHot_Tinted_50pct_N_IQE0"
    glzsys << "Hot_Tinted_50pct_N_IQE0"
    glzsys << "Cold_Tinted_50pct_N_IQE0"
    glzsys << "VeryCold_Tinted_50pct_N_IQE0"
    glzsys << "======================"
    glzsys << "VeryHot_Tinted_50pct_N_IQE0pt4"
    glzsys << "Hot_Tinted_50pct_N_IQE0pt4"
    glzsys << "Cold_Tinted_50pct_N_IQE0pt4"
    glzsys << "VeryCold_Tinted_50pct_N_IQE0pt4"
    glzsys << "======================"
    glzsys << "VeryHot_Tinted_50pct_N_IQE0pt6"
    glzsys << "Hot_Tinted_50pct_N_IQE0pt6"
    glzsys << "Cold_Tinted_50pct_N_IQE0pt6"
    glzsys << "VeryCold_Tinted_50pct_N_IQE0pt6"
    glzsys << "======================"
    glzsys << "VeryHot_Tinted_50pct_N_IQE0pt8"
    glzsys << "Hot_Tinted_50pct_N_IQE0pt8"
    glzsys << "Cold_Tinted_50pct_N_IQE0pt8"
    glzsys << "VeryCold_Tinted_50pct_N_IQE0pt8"
    glzsys << "======================"
    glzsys << "Tinted_50pct_S"
    glzsys << "======================"
    glzsys << "VeryHot_Tinted_50pct_S_IQE0"
    glzsys << "Hot_Tinted_50pct_S_IQE0"
    glzsys << "Cold_Tinted_50pct_S_IQE0"
    glzsys << "VeryCold_Tinted_50pct_S_IQE0"
    glzsys << "======================"
    glzsys << "VeryHot_Tinted_50pct_S_IQE0pt4"
    glzsys << "Hot_Tinted_50pct_S_IQE0pt4"
    glzsys << "Cold_Tinted_50pct_S_IQE0pt4"
    glzsys << "VeryCold_Tinted_50pct_S_IQE0pt4"
    glzsys << "======================"
    glzsys << "VeryHot_Tinted_50pct_S_IQE0pt6"
    glzsys << "Hot_Tinted_50pct_S_IQE0pt6"
    glzsys << "Cold_Tinted_50pct_S_IQE0pt6"
    glzsys << "VeryCold_Tinted_50pct_S_IQE0pt6"
    glzsys << "======================"
    glzsys << "VeryHot_Tinted_50pct_S_IQE0pt8"
    glzsys << "Hot_Tinted_50pct_S_IQE0pt8"
    glzsys << "Cold_Tinted_50pct_S_IQE0pt8"
    glzsys << "VeryCold_Tinted_50pct_S_IQE0pt8"
    glzsys << "======================"
    glzsys << "SwitchGlaze"
    glzsys << "======================"
    glzsys << "0pt5pct_N_IQE0"
    glzsys << "0pt5pct_N_IQE0pt4"
    glzsys << "0pt5pct_N_IQE0pt6"
    glzsys << "0pt5pct_N_IQE0pt8"
    glzsys << "5pct_N_IQE0"
    glzsys << "5pct_N_IQE0pt4"
    glzsys << "5pct_N_IQE0pt6"
    glzsys << "5pct_N_IQE0pt8"
    glzsys << "10pct_N_IQE0"
    glzsys << "10pct_N_IQE0pt4"
    glzsys << "10pct_N_IQE0pt6"
    glzsys << "10pct_N_IQE0pt8"
    glzsys << "15pct_N_IQE0"
    glzsys << "15pct_N_IQE0pt4"
    glzsys << "15pct_N_IQE0pt6"
    glzsys << "15pct_N_IQE0pt8"
    glzsys << "20pct_N_IQE0"
    glzsys << "20pct_N_IQE0pt4"
    glzsys << "20pct_N_IQE0pt6"
    glzsys << "20pct_N_IQE0pt8"
    glzsys << "25pct_N_IQE0"
    glzsys << "25pct_N_IQE0pt4"
    glzsys << "25pct_N_IQE0pt6"
    glzsys << "25pct_N_IQE0pt8"
    glzsys << "Triple_0pt5pct_N_IQE0"
    glzsys << "Triple_0pt5pct_N_IQE0pt4"
    glzsys << "Triple_0pt5pct_N_IQE0pt6"
    glzsys << "Triple_0pt5pct_N_IQE0pt8"
    glzsys << "Triple_5pct_N_IQE0"
    glzsys << "Triple_5pct_N_IQE0pt4"
    glzsys << "Triple_5pct_N_IQE0pt6"
    glzsys << "Triple_5pct_N_IQE0pt8"
    glzsys << "VIG_0pt5pct_N_IQE0"
    glzsys << "VIG_0pt5pct_N_IQE0pt4"
    glzsys << "VIG_0pt5pct_N_IQE0pt6"
    glzsys << "VIG_0pt5pct_N_IQE0pt8"
    glzsys << "VIG_5pct_N_IQE0"
    glzsys << "VIG_5pct_N_IQE0pt4"
    glzsys << "VIG_5pct_N_IQE0pt6"
    glzsys << "VIG_5pct_N_IQE0pt8"
    glzsys << "======================"
    glzsys << "Old Windows"
    glzsys << "======================"
    glzsys << "Single_Pane"
    glzsys << "Double_Pane"
    glzsys << "======================"
    glzsys << "Triple Pane"
    glzsys << "======================"
    glzsys << "VeryHot_Triple_Pane"
    glzsys << "Hot_Triple_Pane"
    glzsys << "Cold_Triple_Pane"
    glzsys << "VeryCold_Triple_Pane"
    glzsys << "Triple_Tinted_25pct_N_IQE0"
    glzsys << "Triple_Tinted_50pct_N_IQE0"
    glzsys << "Triple_Tinted_50pct_S_IQE0"
    glzsys << "======================"
    glzsys << "VIG"
    glzsys << "======================"
    glzsys << "VeryHot_VIG"
    glzsys << "Hot_VIG"
    glzsys << "Cold_VIG"
    glzsys << "VeryCold_VIG"
    glzsys << "VIG_Tinted_25pct_N_IQE0"
    glzsys << "VIG_Tinted_50pct_N_IQE0"
    glzsys << "VIG_Tinted_50pct_S_IQE0"
    glzsys << "======================"
    glzsys << "Others"
    glzsys << "======================"
    glzsys << "VeryHot_Dark"
    glzsys << "VeryHot_Light"
    glzsys << "Hot_Dark"
    glzsys << "Hot_Light"
    glzsys << "Cold_Dark"
    glzsys << "Cold_Light"
    glzsys << "VeryCold_Dark"
    glzsys << "VeryCold_Light"
    
    glztype = OpenStudio::Ruleset::OSArgument::makeChoiceArgument('glztype', glzsys, true)
    glztype.setDisplayName("Choice of IGU")
    glztype.setDefaultValue("SwitchGlaze")
    args << glztype
    
    #make choice arguments for fenestration surface
    fenestrationsurfaces = workspace.getObjectsByType("FenestrationSurface:Detailed".to_IddObjectType)
    chs = OpenStudio::StringVector.new
    fenestrationsurfaces.each do |fenestrationsurface|
      chs << fenestrationsurface.name.to_s
    end
    chs << $allchoices
    chs << "inferred"
    choice = OpenStudio::Ruleset::OSArgument::makeChoiceArgument('choice', chs, true)
    choice.setDisplayName("Choice of window")
    choice.setDefaultValue($allchoices)
    args << choice
    
    # path to the folder that includes idf files containing window objects
    idf_path = OpenStudio::Ruleset::OSArgument.makeStringArgument("idf_path", true)
    idf_path.setDisplayName("path to the folder that includes idf files containing window objects")
    idf_path.setDefaultValue('C:\SpectralIDFs')
    args << idf_path
    
    # thermochromic window switching temperature
    t_switching = OpenStudio::Ruleset::OSArgument.makeDoubleArgument("t_switching", true)
    t_switching.setDisplayName("Switching temperature of a thermochromic window")
    t_switching.setDescription('Only applicable when thermochromic window is selected')
    t_switching.setUnits("C")
    t_switching.setDefaultValue(35)
    args << t_switching
    
    # 
    serverrun = OpenStudio::Ruleset::OSArgument::makeBoolArgument('serverrun', false)
    serverrun.setDisplayName('Running on the server (and not in local)?')
    serverrun.setDefaultValue('false')
    serverrun.setDescription('Select if simulation is being ran on the server')
    args << serverrun

    return args
  end
  
  def check_upstream_measure_for_arg(runner, arg_name)
    # 2.x methods (currently setup for measure display name but snake_case arg names)
    arg_name_value = {}
    runner.workflow.workflowSteps.each do |step|
      if step.to_MeasureStep.is_initialized
        measure_step = step.to_MeasureStep.get

        measure_name = measure_step.measureDirName
        if measure_step.name.is_initialized
          measure_name = measure_step.name.get # this is instance name in PAT
        end
        if measure_step.result.is_initialized
          result = measure_step.result.get
          result.stepValues.each do |arg|
            name = arg.name
            value = arg.valueAsVariant.to_s
            if name == arg_name
              arg_name_value[:value] = value
              arg_name_value[:measure_name] = measure_name
              return arg_name_value # stop after find first one
            end
          end
        else
          # puts "No result for #{measure_name}"
        end
      else
        # puts "This step is not a measure"
      end
    end

    return arg_name_value
  end

  # define what happens when the measure is run
  def run(workspace, runner, user_arguments)
    super(workspace, runner, user_arguments)

    #use the built-in error checking 
    if not runner.validateUserArguments(arguments(workspace), user_arguments)
      return false
    end
    
    ####################################################################################
    # assign the user inputs to variables
    ####################################################################################
    choice = runner.getStringArgumentValue('choice',user_arguments)
    glztype = runner.getStringArgumentValue('glztype',user_arguments)
    serverrun = runner.getBoolArgumentValue('serverrun',user_arguments)
    idf_path = runner.getStringArgumentValue('idf_path',user_arguments)
    t_switching = runner.getDoubleArgumentValue('t_switching',user_arguments)
    ####################################################################################
    
    dictionary_weather = Hash.new
    dictionary_weather = {
      'USA_AK_Fairbanks.Intl.AP.702610_TMY3.epw' => 'VeryCold',
      'USA_MN_International.Falls.Intl.AP.727470_TMY3.epw' => 'VeryCold',
      'USA_WI_Milwaukee-Mitchell.Intl.AP.726400_TMY3.epw' => 'Cold',
      'USA_NM_Albuquerque.Intl.AP.723650_TMY3.epw' => 'Cold',
      'USA_NY_Buffalo-Greater.Buffalo.Intl.AP.725280_TMY3.epw' => 'Cold',
      'USA_CO_Denver.Intl.AP.725650_TMY3.epw' => 'Cold',
      'USA_MT_Great.Falls.Intl.AP.727750_TMY3.epw' => 'Cold',
      'DEU_Hamburg.101470_IWEC.epw' => 'Cold',
      'USA_NY_New.York-J.F.Kennedy.Intl.AP.744860_TMY3.epw' => 'Cold',
      'USA_MN_Rochester.Intl.AP.726440_TMY3.epw' => 'Cold',
      'USA_WA_Seattle-Tacoma.Intl.AP.727930_TMY3.epw' => 'Cold',
      'JPN_Tokyo.Hyakuri.477150_IWEC.epw' => 'Cold',
      'USA_WA_Port.Angeles-William.R.Fairchild.Intl.AP.727885_TMY3.epw' => 'Cold',
      'USA_GA_Atlanta-Hartsfield-Jackson.Intl.AP.722190_TMY3.epw' => 'Hot',
      'USA_TX_El.Paso.Intl.AP.722700_TMY3.epw' => 'Hot',
      'USA_CA_San.Diego-Lindbergh.Field.722900_TMY3.epw' => 'Hot',
      'USA_HI_Honolulu.Intl.AP.911820_TMY3.epw' => 'VeryHot',
      'SAU_Riyadh.404380_IWEC.epw' => 'VeryHot',
      'SGP_Singapore.486980_IWEC.epw' => 'VeryHot',
      'USA_FL_Tampa.Intl.AP.722110_TMY3.epw' => 'VeryHot',
      'USA_AZ_Tucson.Intl.AP.722740_TMY3.epw' => 'VeryHot'
    }
    
    ####################################################################################
    ####################################################################################
    
    # check if thermochromic was defined in upstream measure AddThermochromicBIPV
    pce_scenario = check_upstream_measure_for_arg(runner, 'pce_scenario')
    pce_scenario = pce_scenario[:value]
    runner.registerInfo("PV PCE scenario type defined in AddThermochromicBIPV measure = #{pce_scenario}")
        
    if pce_scenario=='SwitchGlaze'
      pce_scenario = true
    elsif pce_scenario=='Static'
      pce_scenario = false
    end
    
    pv_eff_fixed = check_upstream_measure_for_arg(runner, 'pv_eff')
    pv_eff_fixed = pv_eff_fixed[:value]
    runner.registerInfo("Fixed PCE (if PCE variation is not applied) = #{pv_eff_fixed}")
    
    # check PV orientation from upstream measure AddThermochromicBIPV
    pv_orientation = check_upstream_measure_for_arg(runner, 'facade')
    pv_orientation = pv_orientation[:value]
    runner.registerInfo("PV orientation defined in AddThermochromicBIPV measure = #{pv_orientation}")
    
    t_switching = check_upstream_measure_for_arg(runner, 'switch_t')
    t_switching = t_switching[:value].to_f
    runner.registerInfo("Thermochromic switching temperature defiend in AddThermochromicBIPV measure = #{t_switching}")
    
    ####################################################################################
    ####################################################################################
    
    if glztype == "ASHRAE_Simplified"
    
      runner.registerInfo("Skipping this measure since using Baseline ASHRAE window.")
      return false
      
    elsif (glztype == "ASHRAE_Detailed")
    
      glztype = "ASHRAE"
      
      location = check_upstream_measure_for_arg(runner, 'weather_file_name')
      location = location[:value].split("\\")[-1]
      runner.registerInfo("Weather file defined in the upstream = #{location}")
      
      climateregion = dictionary_weather[location]
      runner.registerInfo("Simple climate classification for this location = #{climateregion}")
  
      glztype = climateregion.concat("_#{glztype.to_s}")
      runner.registerInfo("Window name to be implemented = #{glztype}")
      
    elsif (glztype == "Triple Pane")
    
      glztype = "Triple_Pane"
      
      location = check_upstream_measure_for_arg(runner, 'weather_file_name')
      location = location[:value].split("\\")[-1]
      runner.registerInfo("Weather file defined in the upstream = #{location}")
      
      climateregion = dictionary_weather[location]
      runner.registerInfo("Simple climate classification for this location = #{climateregion}")
  
      glztype = climateregion.concat("_#{glztype.to_s}")
      runner.registerInfo("Window name to be implemented = #{glztype}")
      
    elsif (glztype == "VIG")
    
      glztype = "VIG"
      
      location = check_upstream_measure_for_arg(runner, 'weather_file_name')
      location = location[:value].split("\\")[-1]
      runner.registerInfo("Weather file defined in the upstream = #{location}")
      
      climateregion = dictionary_weather[location]
      runner.registerInfo("Simple climate classification for this location = #{climateregion}")
  
      glztype = climateregion.concat("_#{glztype.to_s}")
      runner.registerInfo("Window name to be implemented = #{glztype}")
                    
    elsif (glztype == "SwitchGlaze")
    
      glztype = "SwitchGlaze"
      
      location = check_upstream_measure_for_arg(runner, 'weather_file_name')
      location = location[:value].split("\\")[-1]
      runner.registerInfo("Weather file defined in the upstream = #{location}")
      
      climateregion = dictionary_weather[location]
      runner.registerInfo("Simple climate classification for this location = #{climateregion}")
      
      iqe = check_upstream_measure_for_arg(runner, 'iqe')
      iqe = iqe[:value]
      runner.registerInfo("Tint and IQE setting = #{iqe}")
  
      glztype = climateregion.concat("_#{glztype.to_s}")
      glztype = glztype.concat("_"+iqe) #specific string for tinted 1 window files

      runner.registerInfo("glztype = #{glztype}")
      runner.registerInfo("Window name to be implemented = #{glztype}")
    
    elsif (glztype == "Tinted")
    
      glztype = "Tinted"
      
      location = check_upstream_measure_for_arg(runner, 'weather_file_name')
      location = location[:value].split("\\")[-1]
      runner.registerInfo("Weather file defined in the upstream = #{location}")
      
      climateregion = dictionary_weather[location]
      runner.registerInfo("Simple climate classification for this location = #{climateregion}")
      
      iqe = check_upstream_measure_for_arg(runner, 'iqe')
      iqe = iqe[:value]
      runner.registerInfo("Tint and IQE setting = #{iqe}")
  
      glztype = climateregion.concat("_#{glztype.to_s}")
      glztype = glztype.concat("_"+iqe) #specific string for tinted 1 window files

      runner.registerInfo("glztype = #{glztype}")
      runner.registerInfo("Window name to be implemented = #{glztype}")
    
    elsif (glztype == "Tinted_25pct_N")
    
      glztype = "Tinted"
      
      location = check_upstream_measure_for_arg(runner, 'weather_file_name')
      location = location[:value].split("\\")[-1]
      runner.registerInfo("Weather file defined in the upstream = #{location}")
      
      climateregion = dictionary_weather[location]
      runner.registerInfo("Simple climate classification for this location = #{climateregion}")
  
      glztype = climateregion.concat("_#{glztype.to_s}")
      glztype = glztype.concat("_25pct_N_IQE0pt") #specific string for tinted 1 window files
      pce_string = (pv_eff_fixed.to_f*100).to_i
      runner.registerInfo("PCE conversion to string = #{pce_string}")
      if pce_string == 0
        glztype = glztype.gsub("pt","")
      else
        glztype = glztype.concat("#{pce_string.to_s}")
      end
      runner.registerInfo("glztype = #{glztype}")
      
      runner.registerInfo("Window name to be implemented = #{glztype}")
      
    elsif (glztype == "Tinted_50pct_N")
    
      glztype = "Tinted"
      
      location = check_upstream_measure_for_arg(runner, 'weather_file_name')
      location = location[:value].split("\\")[-1]
      runner.registerInfo("Weather file defined in the upstream = #{location}")
      
      climateregion = dictionary_weather[location]
      runner.registerInfo("Simple climate classification for this location = #{climateregion}")
  
      glztype = climateregion.concat("_#{glztype.to_s}")
      glztype = glztype.concat("_50pct_N_IQE0pt") #specific string for tinted 1 window files
      pce_string = (pv_eff_fixed.to_f*100).to_i
      runner.registerInfo("PCE conversion to string = #{pce_string}")
      if pce_string == 0
        glztype = glztype.gsub("pt","")
      else
        glztype = glztype.concat("#{pce_string.to_s}")
      end
      runner.registerInfo("glztype = #{glztype}")
      
      runner.registerInfo("Window name to be implemented = #{glztype}")
          
    elsif (glztype == "Tinted_50pct_S")
    
      glztype = "Tinted"
      
      location = check_upstream_measure_for_arg(runner, 'weather_file_name')
      location = location[:value].split("\\")[-1]
      runner.registerInfo("Weather file defined in the upstream = #{location}")
      
      climateregion = dictionary_weather[location]
      runner.registerInfo("Simple climate classification for this location = #{climateregion}")
  
      glztype = climateregion.concat("_#{glztype.to_s}")
      glztype = glztype.concat("_50pct_S_IQE0pt") #specific string for tinted 1 window files
      pce_string = (pv_eff_fixed.to_f*100).to_i
      runner.registerInfo("PCE conversion to string = #{pce_string}")
      if pce_string == 0
        glztype = glztype.gsub("pt","")
      else
        glztype = glztype.concat("#{pce_string.to_s}")
      end
      runner.registerInfo("glztype = #{glztype}")
      
      runner.registerInfo("Window name to be implemented = #{glztype}")
      
    elsif (glztype == "Triple_Tinted_25pct_N_IQE0")||(glztype == "Triple_Tinted_50pct_N_IQE0")||(glztype == "Triple_Tinted_50pct_S_IQE0")||(glztype == "VIG_Tinted_25pct_N_IQE0")||(glztype == "VIG_Tinted_50pct_N_IQE0")||(glztype == "VIG_Tinted_50pct_S_IQE0")
          
      location = check_upstream_measure_for_arg(runner, 'weather_file_name')
      location = location[:value].split("\\")[-1]
      runner.registerInfo("Weather file defined in the upstream = #{location}")
      
      climateregion = dictionary_weather[location]
      runner.registerInfo("Simple climate classification for this location = #{climateregion}")
  
      glztype = climateregion.concat("_#{glztype.to_s}")
      runner.registerInfo("glztype = #{glztype}")
      
      runner.registerInfo("Window name to be implemented = #{glztype}")
                         
    end
    
    ####################################################################################
    ####################################################################################
    
    
    # Note for setting up dictionary:
    # file names can be anything, but the name of the construction object in the idf file should match with the key of the dictionary, for this setting
    ####################################################################################
    # DIFFERENT DICTIONARIES FOR LOCAL AND SERVER SIMULATION
    ####################################################################################
    dictionary = Hash.new
    
    if serverrun == true
      runner.registerInfo("Reading idf files from the server ../../../lib/resources directory")
      dictionary = {
        "Baseline_GlzSys6" => "../../../lib/resources/GlzSys_16095-air-9_Spec.idf",
        "Baseline_GlzSys13" => "../../../lib/resources/GlzSys_6374-air-3000_Spec.idf",
        "Baseline_GlzSys15" => "../../../lib/resources/GlzSys_10F-air-3000_Spec.idf",
        "Baseline_GlzSys15_withPV" => "../../../lib/resources/GlzSys21_13F-air-3000_Spec.idf",
        "Baseline_GlzSys6_13" => "../../../lib/resources/GlzSys_16095-air-3000_Spec.idf",
        "GlzSys_6_withoutPV" => "../../../lib/resources/GlzSys_10-air-9_Spec.idf",
        "GlzSys_13_withoutPV" => "../../../lib/resources/GlzSys_11F-air-3000_Spec.idf",
        "GlzSys_6_withPV" => "../../../lib/resources/GlzSys19_13F-air-9_Spec.idf",
        "GlzSys_13_withPV" => "../../../lib/resources/GlzSys20_14F-air-3000_Spec.idf",
        "VeryHot_SwitchGlaze" => "../../../lib/resources/SG_zone12_Spec.idf",
        "Hot_SwitchGlaze" => "../../../lib/resources/SG_zone3_Spec.idf",
        "Cold_SwitchGlaze" => "../../../lib/resources/SG_zone456_Spec.idf",
        "VeryCold_SwitchGlaze" => "../../../lib/resources/SG_zone78_Spec.idf",
        "VeryHot_Dark" => "../../../lib/resources/dark_zone12_Spec.idf",
        "VeryHot_Light" => "../../../lib/resources/light_zone12_Spec.idf",
        "Hot_Dark" => "../../../lib/resources/dark_zone3_Spec.idf",
        "Hot_Light" => "../../../lib/resources/light_zone3_Spec.idf", 
        "Cold_Dark" => "../../../lib/resources/dark_zone456_Spec.idf",
        "Cold_Light" => "../../../lib/resources/light_zone456_Spec.idf",
        "VeryCold_Dark" => "../../../lib/resources/dark_zone78_Spec.idf",
        "VeryCold_Light" => "../../../lib/resources/light_zone78_Spec.idf", 
        "Cold_ASHRAE" => "../../../lib/resources/Cold_ASHRAE.idf",
        "Cold_Bleached_0pt5pct_N_IQE0" => "../../../lib/resources/Cold_Bleached_0pt5pct_N_IQE0.idf",
        "Cold_Bleached_0pt5pct_N_IQE0pt4" => "../../../lib/resources/Cold_Bleached_0pt5pct_N_IQE0pt4.idf",
        "Cold_Bleached_0pt5pct_N_IQE0pt6" => "../../../lib/resources/Cold_Bleached_0pt5pct_N_IQE0pt6.idf",
        "Cold_Bleached_0pt5pct_N_IQE0pt8" => "../../../lib/resources/Cold_Bleached_0pt5pct_N_IQE0pt8.idf",
        "Cold_Bleached_5pct_N_IQE0" => "../../../lib/resources/Cold_Bleached_5pct_N_IQE0.idf",
        "Cold_Bleached_5pct_N_IQE0pt4" => "../../../lib/resources/Cold_Bleached_5pct_N_IQE0pt4.idf",
        "Cold_Bleached_5pct_N_IQE0pt6" => "../../../lib/resources/Cold_Bleached_5pct_N_IQE0pt6.idf",
        "Cold_Bleached_5pct_N_IQE0pt8" => "../../../lib/resources/Cold_Bleached_5pct_N_IQE0pt8.idf",
        "Cold_SwitchGlaze_0pt5pct_N_IQE0" => "../../../lib/resources/Cold_SwitchGlaze_0pt5pct_N_IQE0.idf",
        "Cold_SwitchGlaze_0pt5pct_N_IQE0pt4" => "../../../lib/resources/Cold_SwitchGlaze_0pt5pct_N_IQE0pt4.idf",
        "Cold_SwitchGlaze_0pt5pct_N_IQE0pt6" => "../../../lib/resources/Cold_SwitchGlaze_0pt5pct_N_IQE0pt6.idf",
        "Cold_SwitchGlaze_0pt5pct_N_IQE0pt8" => "../../../lib/resources/Cold_SwitchGlaze_0pt5pct_N_IQE0pt8.idf",
        "Cold_SwitchGlaze_5pct_N_IQE0" => "../../../lib/resources/Cold_SwitchGlaze_5pct_N_IQE0.idf",
        "Cold_SwitchGlaze_5pct_N_IQE0pt4" => "../../../lib/resources/Cold_SwitchGlaze_5pct_N_IQE0pt4.idf",
        "Cold_SwitchGlaze_5pct_N_IQE0pt6" => "../../../lib/resources/Cold_SwitchGlaze_5pct_N_IQE0pt6.idf",
        "Cold_SwitchGlaze_5pct_N_IQE0pt8" => "../../../lib/resources/Cold_SwitchGlaze_5pct_N_IQE0pt8.idf",
        "Cold_SwitchGlaze_25pct_N_IQE0" => "../../../lib/resources/Cold_SwitchGlaze_25pct_N_IQE0.idf",
        "Cold_SwitchGlaze_25pct_N_IQE0pt4" => "../../../lib/resources/Cold_SwitchGlaze_25pct_N_IQE0pt4.idf",
        "Cold_SwitchGlaze_25pct_N_IQE0pt6" => "../../../lib/resources/Cold_SwitchGlaze_25pct_N_IQE0pt6.idf",
        "Cold_SwitchGlaze_25pct_N_IQE0pt8" => "../../../lib/resources/Cold_SwitchGlaze_25pct_N_IQE0pt8.idf",
        "Cold_Tinted_0pt5pct_N_IQE0" => "../../../lib/resources/Cold_Tinted_0pt5pct_N_IQE0.idf",
        "Cold_Tinted_0pt5pct_N_IQE0pt4" => "../../../lib/resources/Cold_Tinted_0pt5pct_N_IQE0pt4.idf",
        "Cold_Tinted_0pt5pct_N_IQE0pt6" => "../../../lib/resources/Cold_Tinted_0pt5pct_N_IQE0pt6.idf",
        "Cold_Tinted_0pt5pct_N_IQE0pt8" => "../../../lib/resources/Cold_Tinted_0pt5pct_N_IQE0pt8.idf",
        "Cold_Tinted_25pct_N_IQE0" => "../../../lib/resources/Cold_Tinted_25pct_N_IQE0.idf",
        "Cold_Tinted_25pct_N_IQE0pt4" => "../../../lib/resources/Cold_Tinted_25pct_N_IQE0pt4.idf",
        "Cold_Tinted_25pct_N_IQE0pt6" => "../../../lib/resources/Cold_Tinted_25pct_N_IQE0pt6.idf",
        "Cold_Tinted_25pct_N_IQE0pt8" => "../../../lib/resources/Cold_Tinted_25pct_N_IQE0pt8.idf",
        "Cold_Tinted_50pct_N_IQE0" => "../../../lib/resources/Cold_Tinted_50pct_N_IQE0.idf",
        "Cold_Tinted_50pct_N_IQE0pt4" => "../../../lib/resources/Cold_Tinted_50pct_N_IQE0pt4.idf",
        "Cold_Tinted_50pct_N_IQE0pt6" => "../../../lib/resources/Cold_Tinted_50pct_N_IQE0pt6.idf",
        "Cold_Tinted_50pct_N_IQE0pt8" => "../../../lib/resources/Cold_Tinted_50pct_N_IQE0pt8.idf",
        "Cold_Tinted_50pct_S_IQE0" => "../../../lib/resources/Cold_Tinted_50pct_S_IQE0.idf",
        "Cold_Tinted_50pct_S_IQE0pt4" => "../../../lib/resources/Cold_Tinted_50pct_S_IQE0pt4.idf",
        "Cold_Tinted_50pct_S_IQE0pt6" => "../../../lib/resources/Cold_Tinted_50pct_S_IQE0pt6.idf",
        "Cold_Tinted_50pct_S_IQE0pt8" => "../../../lib/resources/Cold_Tinted_50pct_S_IQE0pt8.idf",
        "Cold_Tinted_5pct_N_IQE0" => "../../../lib/resources/Cold_Tinted_5pct_N_IQE0.idf",
        "Cold_Tinted_5pct_N_IQE0pt4" => "../../../lib/resources/Cold_Tinted_5pct_N_IQE0pt4.idf",
        "Cold_Tinted_5pct_N_IQE0pt6" => "../../../lib/resources/Cold_Tinted_5pct_N_IQE0pt6.idf",
        "Cold_Tinted_5pct_N_IQE0pt8" => "../../../lib/resources/Cold_Tinted_5pct_N_IQE0pt8.idf",
        "Double_Pane" => "../../../lib/resources/Double_Pane.idf",
        "Hot_ASHRAE" => "../../../lib/resources/Hot_ASHRAE.idf",
        "Hot_Bleached_0pt5pct_N_IQE0" => "../../../lib/resources/Hot_Bleached_0pt5pct_N_IQE0.idf",
        "Hot_Bleached_0pt5pct_N_IQE0pt4" => "../../../lib/resources/Hot_Bleached_0pt5pct_N_IQE0pt4.idf",
        "Hot_Bleached_0pt5pct_N_IQE0pt6" => "../../../lib/resources/Hot_Bleached_0pt5pct_N_IQE0pt6.idf",
        "Hot_Bleached_0pt5pct_N_IQE0pt8" => "../../../lib/resources/Hot_Bleached_0pt5pct_N_IQE0pt8.idf",
        "Hot_Bleached_5pct_N_IQE0" => "../../../lib/resources/Hot_Bleached_5pct_N_IQE0.idf",
        "Hot_Bleached_5pct_N_IQE0pt4" => "../../../lib/resources/Hot_Bleached_5pct_N_IQE0pt4.idf",
        "Hot_Bleached_5pct_N_IQE0pt6" => "../../../lib/resources/Hot_Bleached_5pct_N_IQE0pt6.idf",
        "Hot_Bleached_5pct_N_IQE0pt8" => "../../../lib/resources/Hot_Bleached_5pct_N_IQE0pt8.idf",
        "Hot_SwitchGlaze_0pt5pct_N_IQE0" => "../../../lib/resources/Hot_SwitchGlaze_0pt5pct_N_IQE0.idf",
        "Hot_SwitchGlaze_0pt5pct_N_IQE0pt4" => "../../../lib/resources/Hot_SwitchGlaze_0pt5pct_N_IQE0pt4.idf",
        "Hot_SwitchGlaze_0pt5pct_N_IQE0pt6" => "../../../lib/resources/Hot_SwitchGlaze_0pt5pct_N_IQE0pt6.idf",
        "Hot_SwitchGlaze_0pt5pct_N_IQE0pt8" => "../../../lib/resources/Hot_SwitchGlaze_0pt5pct_N_IQE0pt8.idf",
        "Hot_SwitchGlaze_5pct_N_IQE0" => "../../../lib/resources/Hot_SwitchGlaze_5pct_N_IQE0.idf",
        "Hot_SwitchGlaze_5pct_N_IQE0pt4" => "../../../lib/resources/Hot_SwitchGlaze_5pct_N_IQE0pt4.idf",
        "Hot_SwitchGlaze_5pct_N_IQE0pt6" => "../../../lib/resources/Hot_SwitchGlaze_5pct_N_IQE0pt6.idf",
        "Hot_SwitchGlaze_5pct_N_IQE0pt8" => "../../../lib/resources/Hot_SwitchGlaze_5pct_N_IQE0pt8.idf",
        "Hot_SwitchGlaze_25pct_N_IQE0" => "../../../lib/resources/Hot_SwitchGlaze_25pct_N_IQE0.idf",
        "Hot_SwitchGlaze_25pct_N_IQE0pt4" => "../../../lib/resources/Hot_SwitchGlaze_25pct_N_IQE0pt4.idf",
        "Hot_SwitchGlaze_25pct_N_IQE0pt6" => "../../../lib/resources/Hot_SwitchGlaze_25pct_N_IQE0pt6.idf",
        "Hot_SwitchGlaze_25pct_N_IQE0pt8" => "../../../lib/resources/Hot_SwitchGlaze_25pct_N_IQE0pt8.idf",
        "Hot_Tinted_0pt5pct_N_IQE0" => "../../../lib/resources/Hot_Tinted_0pt5pct_N_IQE0.idf",
        "Hot_Tinted_0pt5pct_N_IQE0pt4" => "../../../lib/resources/Hot_Tinted_0pt5pct_N_IQE0pt4.idf",
        "Hot_Tinted_0pt5pct_N_IQE0pt6" => "../../../lib/resources/Hot_Tinted_0pt5pct_N_IQE0pt6.idf",
        "Hot_Tinted_0pt5pct_N_IQE0pt8" => "../../../lib/resources/Hot_Tinted_0pt5pct_N_IQE0pt8.idf",
        "Hot_Tinted_25pct_N_IQE0" => "../../../lib/resources/Hot_Tinted_25pct_N_IQE0.idf",
        "Hot_Tinted_25pct_N_IQE0pt4" => "../../../lib/resources/Hot_Tinted_25pct_N_IQE0pt4.idf",
        "Hot_Tinted_25pct_N_IQE0pt6" => "../../../lib/resources/Hot_Tinted_25pct_N_IQE0pt6.idf",
        "Hot_Tinted_25pct_N_IQE0pt8" => "../../../lib/resources/Hot_Tinted_25pct_N_IQE0pt8.idf",
        "Hot_Tinted_50pct_N_IQE0" => "../../../lib/resources/Hot_Tinted_50pct_N_IQE0.idf",
        "Hot_Tinted_50pct_N_IQE0pt4" => "../../../lib/resources/Hot_Tinted_50pct_N_IQE0pt4.idf",
        "Hot_Tinted_50pct_N_IQE0pt6" => "../../../lib/resources/Hot_Tinted_50pct_N_IQE0pt6.idf",
        "Hot_Tinted_50pct_N_IQE0pt8" => "../../../lib/resources/Hot_Tinted_50pct_N_IQE0pt8.idf",
        "Hot_Tinted_50pct_S_IQE0" => "../../../lib/resources/Hot_Tinted_50pct_S_IQE0.idf",
        "Hot_Tinted_50pct_S_IQE0pt4" => "../../../lib/resources/Hot_Tinted_50pct_S_IQE0pt4.idf",
        "Hot_Tinted_50pct_S_IQE0pt6" => "../../../lib/resources/Hot_Tinted_50pct_S_IQE0pt6.idf",
        "Hot_Tinted_50pct_S_IQE0pt8" => "../../../lib/resources/Hot_Tinted_50pct_S_IQE0pt8.idf",
        "Hot_Tinted_5pct_N_IQE0" => "../../../lib/resources/Hot_Tinted_5pct_N_IQE0.idf",
        "Hot_Tinted_5pct_N_IQE0pt4" => "../../../lib/resources/Hot_Tinted_5pct_N_IQE0pt4.idf",
        "Hot_Tinted_5pct_N_IQE0pt6" => "../../../lib/resources/Hot_Tinted_5pct_N_IQE0pt6.idf",
        "Hot_Tinted_5pct_N_IQE0pt8" => "../../../lib/resources/Hot_Tinted_5pct_N_IQE0pt8.idf",
        "Single_Pane" => "../../../lib/resources/Single_Pane.idf",
        "VeryCold_ASHRAE" => "../../../lib/resources/VeryCold_ASHRAE.idf",
        "VeryCold_Bleached_0pt5pct_N_IQE0" => "../../../lib/resources/VeryCold_Bleached_0pt5pct_N_IQE0.idf",
        "VeryCold_Bleached_0pt5pct_N_IQE0pt4" => "../../../lib/resources/VeryCold_Bleached_0pt5pct_N_IQE0pt4.idf",
        "VeryCold_Bleached_0pt5pct_N_IQE0pt6" => "../../../lib/resources/VeryCold_Bleached_0pt5pct_N_IQE0pt6.idf",
        "VeryCold_Bleached_0pt5pct_N_IQE0pt8" => "../../../lib/resources/VeryCold_Bleached_0pt5pct_N_IQE0pt8.idf",
        "VeryCold_Bleached_5pct_N_IQE0" => "../../../lib/resources/VeryCold_Bleached_5pct_N_IQE0.idf",
        "VeryCold_Bleached_5pct_N_IQE0pt4" => "../../../lib/resources/VeryCold_Bleached_5pct_N_IQE0pt4.idf",
        "VeryCold_Bleached_5pct_N_IQE0pt6" => "../../../lib/resources/VeryCold_Bleached_5pct_N_IQE0pt6.idf",
        "VeryCold_Bleached_5pct_N_IQE0pt8" => "../../../lib/resources/VeryCold_Bleached_5pct_N_IQE0pt8.idf",
        "VeryCold_SwitchGlaze_0pt5pct_N_IQE0" => "../../../lib/resources/VeryCold_SwitchGlaze_0pt5pct_N_IQE0.idf",
        "VeryCold_SwitchGlaze_0pt5pct_N_IQE0pt4" => "../../../lib/resources/VeryCold_SwitchGlaze_0pt5pct_N_IQE0pt4.idf",
        "VeryCold_SwitchGlaze_0pt5pct_N_IQE0pt6" => "../../../lib/resources/VeryCold_SwitchGlaze_0pt5pct_N_IQE0pt6.idf",
        "VeryCold_SwitchGlaze_0pt5pct_N_IQE0pt8" => "../../../lib/resources/VeryCold_SwitchGlaze_0pt5pct_N_IQE0pt8.idf",
        "VeryCold_SwitchGlaze_5pct_N_IQE0" => "../../../lib/resources/VeryCold_SwitchGlaze_5pct_N_IQE0.idf",
        "VeryCold_SwitchGlaze_5pct_N_IQE0pt4" => "../../../lib/resources/VeryCold_SwitchGlaze_5pct_N_IQE0pt4.idf",
        "VeryCold_SwitchGlaze_5pct_N_IQE0pt6" => "../../../lib/resources/VeryCold_SwitchGlaze_5pct_N_IQE0pt6.idf",
        "VeryCold_SwitchGlaze_5pct_N_IQE0pt8" => "../../../lib/resources/VeryCold_SwitchGlaze_5pct_N_IQE0pt8.idf",
        "VeryCold_SwitchGlaze_25pct_N_IQE0" => "../../../lib/resources/VeryCold_SwitchGlaze_25pct_N_IQE0.idf",
        "VeryCold_SwitchGlaze_25pct_N_IQE0pt4" => "../../../lib/resources/VeryCold_SwitchGlaze_25pct_N_IQE0pt4.idf",
        "VeryCold_SwitchGlaze_25pct_N_IQE0pt6" => "../../../lib/resources/VeryCold_SwitchGlaze_25pct_N_IQE0pt6.idf",
        "VeryCold_SwitchGlaze_25pct_N_IQE0pt8" => "../../../lib/resources/VeryCold_SwitchGlaze_25pct_N_IQE0pt8.idf",
        "VeryCold_Tinted_0pt5pct_N_IQE0" => "../../../lib/resources/VeryCold_Tinted_0pt5pct_N_IQE0.idf",
        "VeryCold_Tinted_0pt5pct_N_IQE0pt4" => "../../../lib/resources/VeryCold_Tinted_0pt5pct_N_IQE0pt4.idf",
        "VeryCold_Tinted_0pt5pct_N_IQE0pt6" => "../../../lib/resources/VeryCold_Tinted_0pt5pct_N_IQE0pt6.idf",
        "VeryCold_Tinted_0pt5pct_N_IQE0pt8" => "../../../lib/resources/VeryCold_Tinted_0pt5pct_N_IQE0pt8.idf",
        "VeryCold_Tinted_25pct_N_IQE0" => "../../../lib/resources/VeryCold_Tinted_25pct_N_IQE0.idf",
        "VeryCold_Tinted_25pct_N_IQE0pt4" => "../../../lib/resources/VeryCold_Tinted_25pct_N_IQE0pt4.idf",
        "VeryCold_Tinted_25pct_N_IQE0pt6" => "../../../lib/resources/VeryCold_Tinted_25pct_N_IQE0pt6.idf",
        "VeryCold_Tinted_25pct_N_IQE0pt8" => "../../../lib/resources/VeryCold_Tinted_25pct_N_IQE0pt8.idf",
        "VeryCold_Tinted_50pct_N_IQE0" => "../../../lib/resources/VeryCold_Tinted_50pct_N_IQE0.idf",
        "VeryCold_Tinted_50pct_N_IQE0pt4" => "../../../lib/resources/VeryCold_Tinted_50pct_N_IQE0pt4.idf",
        "VeryCold_Tinted_50pct_N_IQE0pt6" => "../../../lib/resources/VeryCold_Tinted_50pct_N_IQE0pt6.idf",
        "VeryCold_Tinted_50pct_N_IQE0pt8" => "../../../lib/resources/VeryCold_Tinted_50pct_N_IQE0pt8.idf",
        "VeryCold_Tinted_50pct_S_IQE0" => "../../../lib/resources/VeryCold_Tinted_50pct_S_IQE0.idf",
        "VeryCold_Tinted_50pct_S_IQE0pt4" => "../../../lib/resources/VeryCold_Tinted_50pct_S_IQE0pt4.idf",
        "VeryCold_Tinted_50pct_S_IQE0pt6" => "../../../lib/resources/VeryCold_Tinted_50pct_S_IQE0pt6.idf",
        "VeryCold_Tinted_50pct_S_IQE0pt8" => "../../../lib/resources/VeryCold_Tinted_50pct_S_IQE0pt8.idf",
        "VeryCold_Tinted_5pct_N_IQE0" => "../../../lib/resources/VeryCold_Tinted_5pct_N_IQE0.idf",
        "VeryCold_Tinted_5pct_N_IQE0pt4" => "../../../lib/resources/VeryCold_Tinted_5pct_N_IQE0pt4.idf",
        "VeryCold_Tinted_5pct_N_IQE0pt6" => "../../../lib/resources/VeryCold_Tinted_5pct_N_IQE0pt6.idf",
        "VeryCold_Tinted_5pct_N_IQE0pt8" => "../../../lib/resources/VeryCold_Tinted_5pct_N_IQE0pt8.idf",
        "VeryHot_ASHRAE" => "../../../lib/resources/VeryHot_ASHRAE.idf",
        "VeryHot_Bleached_0pt5pct_N_IQE0" => "../../../lib/resources/VeryHot_Bleached_0pt5pct_N_IQE0.idf",
        "VeryHot_Bleached_0pt5pct_N_IQE0pt4" => "../../../lib/resources/VeryHot_Bleached_0pt5pct_N_IQE0pt4.idf",
        "VeryHot_Bleached_0pt5pct_N_IQE0pt6" => "../../../lib/resources/VeryHot_Bleached_0pt5pct_N_IQE0pt6.idf",
        "VeryHot_Bleached_0pt5pct_N_IQE0pt8" => "../../../lib/resources/VeryHot_Bleached_0pt5pct_N_IQE0pt8.idf",
        "VeryHot_Bleached_5pct_N_IQE0" => "../../../lib/resources/VeryHot_Bleached_5pct_N_IQE0.idf",
        "VeryHot_Bleached_5pct_N_IQE0pt4" => "../../../lib/resources/VeryHot_Bleached_5pct_N_IQE0pt4.idf",
        "VeryHot_Bleached_5pct_N_IQE0pt6" => "../../../lib/resources/VeryHot_Bleached_5pct_N_IQE0pt6.idf",
        "VeryHot_Bleached_5pct_N_IQE0pt8" => "../../../lib/resources/VeryHot_Bleached_5pct_N_IQE0pt8.idf",
        "VeryHot_SwitchGlaze_0pt5pct_N_IQE0" => "../../../lib/resources/VeryHot_SwitchGlaze_0pt5pct_N_IQE0.idf",
        "VeryHot_SwitchGlaze_0pt5pct_N_IQE0pt4" => "../../../lib/resources/VeryHot_SwitchGlaze_0pt5pct_N_IQE0pt4.idf",
        "VeryHot_SwitchGlaze_0pt5pct_N_IQE0pt6" => "../../../lib/resources/VeryHot_SwitchGlaze_0pt5pct_N_IQE0pt6.idf",
        "VeryHot_SwitchGlaze_0pt5pct_N_IQE0pt8" => "../../../lib/resources/VeryHot_SwitchGlaze_0pt5pct_N_IQE0pt8.idf",
        "VeryHot_SwitchGlaze_5pct_N_IQE0" => "../../../lib/resources/VeryHot_SwitchGlaze_5pct_N_IQE0.idf",
        "VeryHot_SwitchGlaze_5pct_N_IQE0pt4" => "../../../lib/resources/VeryHot_SwitchGlaze_5pct_N_IQE0pt4.idf",
        "VeryHot_SwitchGlaze_5pct_N_IQE0pt6" => "../../../lib/resources/VeryHot_SwitchGlaze_5pct_N_IQE0pt6.idf",
        "VeryHot_SwitchGlaze_5pct_N_IQE0pt8" => "../../../lib/resources/VeryHot_SwitchGlaze_5pct_N_IQE0pt8.idf",
        "VeryHot_SwitchGlaze_25pct_N_IQE0" => "../../../lib/resources/VeryHot_SwitchGlaze_25pct_N_IQE0.idf",
        "VeryHot_SwitchGlaze_25pct_N_IQE0pt4" => "../../../lib/resources/VeryHot_SwitchGlaze_25pct_N_IQE0pt4.idf",
        "VeryHot_SwitchGlaze_25pct_N_IQE0pt6" => "../../../lib/resources/VeryHot_SwitchGlaze_25pct_N_IQE0pt6.idf",
        "VeryHot_SwitchGlaze_25pct_N_IQE0pt8" => "../../../lib/resources/VeryHot_SwitchGlaze_25pct_N_IQE0pt8.idf",
        "VeryHot_Tinted_0pt5pct_N_IQE0" => "../../../lib/resources/VeryHot_Tinted_0pt5pct_N_IQE0.idf",
        "VeryHot_Tinted_0pt5pct_N_IQE0pt4" => "../../../lib/resources/VeryHot_Tinted_0pt5pct_N_IQE0pt4.idf",
        "VeryHot_Tinted_0pt5pct_N_IQE0pt6" => "../../../lib/resources/VeryHot_Tinted_0pt5pct_N_IQE0pt6.idf",
        "VeryHot_Tinted_0pt5pct_N_IQE0pt8" => "../../../lib/resources/VeryHot_Tinted_0pt5pct_N_IQE0pt8.idf",
        "VeryHot_Tinted_25pct_N_IQE0" => "../../../lib/resources/VeryHot_Tinted_25pct_N_IQE0.idf",
        "VeryHot_Tinted_25pct_N_IQE0pt4" => "../../../lib/resources/VeryHot_Tinted_25pct_N_IQE0pt4.idf",
        "VeryHot_Tinted_25pct_N_IQE0pt6" => "../../../lib/resources/VeryHot_Tinted_25pct_N_IQE0pt6.idf",
        "VeryHot_Tinted_25pct_N_IQE0pt8" => "../../../lib/resources/VeryHot_Tinted_25pct_N_IQE0pt8.idf",
        "VeryHot_Tinted_50pct_N_IQE0" => "../../../lib/resources/VeryHot_Tinted_50pct_N_IQE0.idf",
        "VeryHot_Tinted_50pct_N_IQE0pt4" => "../../../lib/resources/VeryHot_Tinted_50pct_N_IQE0pt4.idf",
        "VeryHot_Tinted_50pct_N_IQE0pt6" => "../../../lib/resources/VeryHot_Tinted_50pct_N_IQE0pt6.idf",
        "VeryHot_Tinted_50pct_N_IQE0pt8" => "../../../lib/resources/VeryHot_Tinted_50pct_N_IQE0pt8.idf",
        "VeryHot_Tinted_50pct_S_IQE0" => "../../../lib/resources/VeryHot_Tinted_50pct_S_IQE0.idf",
        "VeryHot_Tinted_50pct_S_IQE0pt4" => "../../../lib/resources/VeryHot_Tinted_50pct_S_IQE0pt4.idf",
        "VeryHot_Tinted_50pct_S_IQE0pt6" => "../../../lib/resources/VeryHot_Tinted_50pct_S_IQE0pt6.idf",
        "VeryHot_Tinted_50pct_S_IQE0pt8" => "../../../lib/resources/VeryHot_Tinted_50pct_S_IQE0pt8.idf",
        "VeryHot_Tinted_5pct_N_IQE0" => "../../../lib/resources/VeryHot_Tinted_5pct_N_IQE0.idf",
        "VeryHot_Tinted_5pct_N_IQE0pt4" => "../../../lib/resources/VeryHot_Tinted_5pct_N_IQE0pt4.idf",
        "VeryHot_Tinted_5pct_N_IQE0pt6" => "../../../lib/resources/VeryHot_Tinted_5pct_N_IQE0pt6.idf",
        "VeryHot_Tinted_5pct_N_IQE0pt8" => "../../../lib/resources/VeryHot_Tinted_5pct_N_IQE0pt8.idf",
        "Cold_SwitchGlaze_10pct_N_IQE0pt4" => "../../../lib/resources/Cold_SwitchGlaze_10pct_N_IQE0pt4.idf",
        "Cold_SwitchGlaze_10pct_N_IQE0pt6" => "../../../lib/resources/Cold_SwitchGlaze_10pct_N_IQE0pt6.idf",
        "Cold_SwitchGlaze_10pct_N_IQE0pt8" => "../../../lib/resources/Cold_SwitchGlaze_10pct_N_IQE0pt8.idf",
        "Cold_SwitchGlaze_15pct_N_IQE0pt4" => "../../../lib/resources/Cold_SwitchGlaze_15pct_N_IQE0pt4.idf",
        "Cold_SwitchGlaze_15pct_N_IQE0pt6" => "../../../lib/resources/Cold_SwitchGlaze_15pct_N_IQE0pt6.idf",
        "Cold_SwitchGlaze_15pct_N_IQE0pt8" => "../../../lib/resources/Cold_SwitchGlaze_15pct_N_IQE0pt8.idf",
        "Cold_SwitchGlaze_20pct_N_IQE0pt4" => "../../../lib/resources/Cold_SwitchGlaze_20pct_N_IQE0pt4.idf",
        "Cold_SwitchGlaze_20pct_N_IQE0pt6" => "../../../lib/resources/Cold_SwitchGlaze_20pct_N_IQE0pt6.idf",
        "Cold_SwitchGlaze_20pct_N_IQE0pt8" => "../../../lib/resources/Cold_SwitchGlaze_20pct_N_IQE0pt8.idf",
        "Hot_SwitchGlaze_10pct_N_IQE0pt4" => "../../../lib/resources/Hot_SwitchGlaze_10pct_N_IQE0pt4.idf",
        "Hot_SwitchGlaze_10pct_N_IQE0pt6" => "../../../lib/resources/Hot_SwitchGlaze_10pct_N_IQE0pt6.idf",
        "Hot_SwitchGlaze_10pct_N_IQE0pt8" => "../../../lib/resources/Hot_SwitchGlaze_10pct_N_IQE0pt8.idf",
        "Hot_SwitchGlaze_15pct_N_IQE0pt4" => "../../../lib/resources/Hot_SwitchGlaze_15pct_N_IQE0pt4.idf",
        "Hot_SwitchGlaze_15pct_N_IQE0pt6" => "../../../lib/resources/Hot_SwitchGlaze_15pct_N_IQE0pt6.idf",
        "Hot_SwitchGlaze_15pct_N_IQE0pt8" => "../../../lib/resources/Hot_SwitchGlaze_15pct_N_IQE0pt8.idf",
        "Hot_SwitchGlaze_20pct_N_IQE0pt4" => "../../../lib/resources/Hot_SwitchGlaze_20pct_N_IQE0pt4.idf",
        "Hot_SwitchGlaze_20pct_N_IQE0pt6" => "../../../lib/resources/Hot_SwitchGlaze_20pct_N_IQE0pt6.idf",
        "Hot_SwitchGlaze_20pct_N_IQE0pt8" => "../../../lib/resources/Hot_SwitchGlaze_20pct_N_IQE0pt8.idf",
        "VeryCold_SwitchGlaze_10pct_N_IQE0pt4" => "../../../lib/resources/VeryCold_SwitchGlaze_10pct_N_IQE0pt4.idf",
        "VeryCold_SwitchGlaze_10pct_N_IQE0pt6" => "../../../lib/resources/VeryCold_SwitchGlaze_10pct_N_IQE0pt6.idf",
        "VeryCold_SwitchGlaze_10pct_N_IQE0pt8" => "../../../lib/resources/VeryCold_SwitchGlaze_10pct_N_IQE0pt8.idf",
        "VeryCold_SwitchGlaze_15pct_N_IQE0pt4" => "../../../lib/resources/VeryCold_SwitchGlaze_15pct_N_IQE0pt4.idf",
        "VeryCold_SwitchGlaze_15pct_N_IQE0pt6" => "../../../lib/resources/VeryCold_SwitchGlaze_15pct_N_IQE0pt6.idf",
        "VeryCold_SwitchGlaze_15pct_N_IQE0pt8" => "../../../lib/resources/VeryCold_SwitchGlaze_15pct_N_IQE0pt8.idf",
        "VeryCold_SwitchGlaze_20pct_N_IQE0pt4" => "../../../lib/resources/VeryCold_SwitchGlaze_20pct_N_IQE0pt4.idf",
        "VeryCold_SwitchGlaze_20pct_N_IQE0pt6" => "../../../lib/resources/VeryCold_SwitchGlaze_20pct_N_IQE0pt6.idf",
        "VeryCold_SwitchGlaze_20pct_N_IQE0pt8" => "../../../lib/resources/VeryCold_SwitchGlaze_20pct_N_IQE0pt8.idf",
        "VeryHot_SwitchGlaze_10pct_N_IQE0pt4" => "../../../lib/resources/VeryHot_SwitchGlaze_10pct_N_IQE0pt4.idf",
        "VeryHot_SwitchGlaze_10pct_N_IQE0pt6" => "../../../lib/resources/VeryHot_SwitchGlaze_10pct_N_IQE0pt6.idf",
        "VeryHot_SwitchGlaze_10pct_N_IQE0pt8" => "../../../lib/resources/VeryHot_SwitchGlaze_10pct_N_IQE0pt8.idf",
        "VeryHot_SwitchGlaze_15pct_N_IQE0pt4" => "../../../lib/resources/VeryHot_SwitchGlaze_15pct_N_IQE0pt4.idf",
        "VeryHot_SwitchGlaze_15pct_N_IQE0pt6" => "../../../lib/resources/VeryHot_SwitchGlaze_15pct_N_IQE0pt6.idf",
        "VeryHot_SwitchGlaze_15pct_N_IQE0pt8" => "../../../lib/resources/VeryHot_SwitchGlaze_15pct_N_IQE0pt8.idf",
        "VeryHot_SwitchGlaze_20pct_N_IQE0pt4" => "../../../lib/resources/VeryHot_SwitchGlaze_20pct_N_IQE0pt4.idf",
        "VeryHot_SwitchGlaze_20pct_N_IQE0pt6" => "../../../lib/resources/VeryHot_SwitchGlaze_20pct_N_IQE0pt6.idf",
        "VeryHot_SwitchGlaze_20pct_N_IQE0pt8" => "../../../lib/resources/VeryHot_SwitchGlaze_20pct_N_IQE0pt8.idf",
        "VeryHot_Triple_Pane" => "../../../lib/resources/VeryHot_Triple_Pane.idf",
        "Hot_Triple_Pane" => "../../../lib/resources/Hot_Triple_Pane.idf",
        "Cold_Triple_Pane" => "../../../lib/resources/Cold_Triple_Pane.idf",
        "VeryCold_Triple_Pane" => "../../../lib/resources/VeryCold_Triple_Pane.idf",
        "VeryHot_VIG" => "../../../lib/resources/VeryHot_VIG.idf",
        "Hot_VIG" => "../../../lib/resources/Hot_VIG.idf",
        "Cold_VIG" => "../../../lib/resources/Cold_VIG.idf",
        "VeryCold_VIG" => "../../../lib/resources/VeryCold_VIG.idf",
        "VeryHot_SwitchGlaze_Triple_0pt5pct_N_IQE0" => "../../../lib/resources/VeryHot_SwitchGlaze_Triple_0pt5pct_N_IQE0.idf",
        "VeryHot_SwitchGlaze_Triple_0pt5pct_N_IQE0pt4" => "../../../lib/resources/VeryHot_SwitchGlaze_Triple_0pt5pct_N_IQE0pt4.idf",
        "VeryHot_SwitchGlaze_Triple_0pt5pct_N_IQE0pt6" => "../../../lib/resources/VeryHot_SwitchGlaze_Triple_0pt5pct_N_IQE0pt6.idf",
        "VeryHot_SwitchGlaze_Triple_0pt5pct_N_IQE0pt8" => "../../../lib/resources/VeryHot_SwitchGlaze_Triple_0pt5pct_N_IQE0pt8.idf",
        "Hot_SwitchGlaze_Triple_0pt5pct_N_IQE0" => "../../../lib/resources/Hot_SwitchGlaze_Triple_0pt5pct_N_IQE0.idf",
        "Hot_SwitchGlaze_Triple_0pt5pct_N_IQE0pt4" => "../../../lib/resources/Hot_SwitchGlaze_Triple_0pt5pct_N_IQE0pt4.idf",
        "Hot_SwitchGlaze_Triple_0pt5pct_N_IQE0pt6" => "../../../lib/resources/Hot_SwitchGlaze_Triple_0pt5pct_N_IQE0pt6.idf",
        "Hot_SwitchGlaze_Triple_0pt5pct_N_IQE0pt8" => "../../../lib/resources/Hot_SwitchGlaze_Triple_0pt5pct_N_IQE0pt8.idf",
        "Cold_SwitchGlaze_Triple_0pt5pct_N_IQE0" => "../../../lib/resources/Cold_SwitchGlaze_Triple_0pt5pct_N_IQE0.idf",
        "Cold_SwitchGlaze_Triple_0pt5pct_N_IQE0pt4" => "../../../lib/resources/Cold_SwitchGlaze_Triple_0pt5pct_N_IQE0pt4.idf",
        "Cold_SwitchGlaze_Triple_0pt5pct_N_IQE0pt6" => "../../../lib/resources/Cold_SwitchGlaze_Triple_0pt5pct_N_IQE0pt6.idf",
        "Cold_SwitchGlaze_Triple_0pt5pct_N_IQE0pt8" => "../../../lib/resources/Cold_SwitchGlaze_Triple_0pt5pct_N_IQE0pt8.idf",
        "VeryCold_SwitchGlaze_Triple_0pt5pct_N_IQE0" => "../../../lib/resources/VeryCold_SwitchGlaze_Triple_0pt5pct_N_IQE0.idf",
        "VeryCold_SwitchGlaze_Triple_0pt5pct_N_IQE0pt4" => "../../../lib/resources/VeryCold_SwitchGlaze_Triple_0pt5pct_N_IQE0pt4.idf",
        "VeryCold_SwitchGlaze_Triple_0pt5pct_N_IQE0pt6" => "../../../lib/resources/VeryCold_SwitchGlaze_Triple_0pt5pct_N_IQE0pt6.idf",
        "VeryCold_SwitchGlaze_Triple_0pt5pct_N_IQE0pt8" => "../../../lib/resources/VeryCold_SwitchGlaze_Triple_0pt5pct_N_IQE0pt8.idf",
        "VeryHot_SwitchGlaze_Triple_5pct_N_IQE0" => "../../../lib/resources/VeryHot_SwitchGlaze_Triple_5pct_N_IQE0.idf",
        "VeryHot_SwitchGlaze_Triple_5pct_N_IQE0pt4" => "../../../lib/resources/VeryHot_SwitchGlaze_Triple_5pct_N_IQE0pt4.idf",
        "VeryHot_SwitchGlaze_Triple_5pct_N_IQE0pt6" => "../../../lib/resources/VeryHot_SwitchGlaze_Triple_5pct_N_IQE0pt6.idf",
        "VeryHot_SwitchGlaze_Triple_5pct_N_IQE0pt8" => "../../../lib/resources/VeryHot_SwitchGlaze_Triple_5pct_N_IQE0pt8.idf",
        "Hot_SwitchGlaze_Triple_5pct_N_IQE0" => "../../../lib/resources/Hot_SwitchGlaze_Triple_5pct_N_IQE0.idf",
        "Hot_SwitchGlaze_Triple_5pct_N_IQE0pt4" => "../../../lib/resources/Hot_SwitchGlaze_Triple_5pct_N_IQE0pt4.idf",
        "Hot_SwitchGlaze_Triple_5pct_N_IQE0pt6" => "../../../lib/resources/Hot_SwitchGlaze_Triple_5pct_N_IQE0pt6.idf",
        "Hot_SwitchGlaze_Triple_5pct_N_IQE0pt8" => "../../../lib/resources/Hot_SwitchGlaze_Triple_5pct_N_IQE0pt8.idf",
        "Cold_SwitchGlaze_Triple_5pct_N_IQE0" => "../../../lib/resources/Cold_SwitchGlaze_Triple_5pct_N_IQE0.idf",
        "Cold_SwitchGlaze_Triple_5pct_N_IQE0pt4" => "../../../lib/resources/Cold_SwitchGlaze_Triple_5pct_N_IQE0pt4.idf",
        "Cold_SwitchGlaze_Triple_5pct_N_IQE0pt6" => "../../../lib/resources/Cold_SwitchGlaze_Triple_5pct_N_IQE0pt6.idf",
        "Cold_SwitchGlaze_Triple_5pct_N_IQE0pt8" => "../../../lib/resources/Cold_SwitchGlaze_Triple_5pct_N_IQE0pt8.idf",
        "VeryCold_SwitchGlaze_Triple_5pct_N_IQE0" => "../../../lib/resources/VeryCold_SwitchGlaze_Triple_5pct_N_IQE0.idf",
        "VeryCold_SwitchGlaze_Triple_5pct_N_IQE0pt4" => "../../../lib/resources/VeryCold_SwitchGlaze_Triple_5pct_N_IQE0pt4.idf",
        "VeryCold_SwitchGlaze_Triple_5pct_N_IQE0pt6" => "../../../lib/resources/VeryCold_SwitchGlaze_Triple_5pct_N_IQE0pt6.idf",
        "VeryCold_SwitchGlaze_Triple_5pct_N_IQE0pt8" => "../../../lib/resources/VeryCold_SwitchGlaze_Triple_5pct_N_IQE0pt8.idf",
        "VeryHot_SwitchGlaze_VIG_0pt5pct_N_IQE0" => "../../../lib/resources/VeryHot_SwitchGlaze_VIG_0pt5pct_N_IQE0.idf",
        "VeryHot_SwitchGlaze_VIG_0pt5pct_N_IQE0pt4" => "../../../lib/resources/VeryHot_SwitchGlaze_VIG_0pt5pct_N_IQE0pt4.idf",
        "VeryHot_SwitchGlaze_VIG_0pt5pct_N_IQE0pt6" => "../../../lib/resources/VeryHot_SwitchGlaze_VIG_0pt5pct_N_IQE0pt6.idf",
        "VeryHot_SwitchGlaze_VIG_0pt5pct_N_IQE0pt8" => "../../../lib/resources/VeryHot_SwitchGlaze_VIG_0pt5pct_N_IQE0pt8.idf",
        "Hot_SwitchGlaze_VIG_0pt5pct_N_IQE0" => "../../../lib/resources/Hot_SwitchGlaze_VIG_0pt5pct_N_IQE0.idf",
        "Hot_SwitchGlaze_VIG_0pt5pct_N_IQE0pt4" => "../../../lib/resources/Hot_SwitchGlaze_VIG_0pt5pct_N_IQE0pt4.idf",
        "Hot_SwitchGlaze_VIG_0pt5pct_N_IQE0pt6" => "../../../lib/resources/Hot_SwitchGlaze_VIG_0pt5pct_N_IQE0pt6.idf",
        "Hot_SwitchGlaze_VIG_0pt5pct_N_IQE0pt8" => "../../../lib/resources/Hot_SwitchGlaze_VIG_0pt5pct_N_IQE0pt8.idf",
        "Cold_SwitchGlaze_VIG_0pt5pct_N_IQE0" => "../../../lib/resources/Cold_SwitchGlaze_VIG_0pt5pct_N_IQE0.idf",
        "Cold_SwitchGlaze_VIG_0pt5pct_N_IQE0pt4" => "../../../lib/resources/Cold_SwitchGlaze_VIG_0pt5pct_N_IQE0pt4.idf",
        "Cold_SwitchGlaze_VIG_0pt5pct_N_IQE0pt6" => "../../../lib/resources/Cold_SwitchGlaze_VIG_0pt5pct_N_IQE0pt6.idf",
        "Cold_SwitchGlaze_VIG_0pt5pct_N_IQE0pt8" => "../../../lib/resources/Cold_SwitchGlaze_VIG_0pt5pct_N_IQE0pt8.idf",
        "VeryCold_SwitchGlaze_VIG_0pt5pct_N_IQE0" => "../../../lib/resources/VeryCold_SwitchGlaze_VIG_0pt5pct_N_IQE0.idf",
        "VeryCold_SwitchGlaze_VIG_0pt5pct_N_IQE0pt4" => "../../../lib/resources/VeryCold_SwitchGlaze_VIG_0pt5pct_N_IQE0pt4.idf",
        "VeryCold_SwitchGlaze_VIG_0pt5pct_N_IQE0pt6" => "../../../lib/resources/VeryCold_SwitchGlaze_VIG_0pt5pct_N_IQE0pt6.idf",
        "VeryCold_SwitchGlaze_VIG_0pt5pct_N_IQE0pt8" => "../../../lib/resources/VeryCold_SwitchGlaze_VIG_0pt5pct_N_IQE0pt8.idf",
        "VeryHot_SwitchGlaze_VIG_5pct_N_IQE0" => "../../../lib/resources/VeryHot_SwitchGlaze_VIG_5pct_N_IQE0.idf",
        "VeryHot_SwitchGlaze_VIG_5pct_N_IQE0pt4" => "../../../lib/resources/VeryHot_SwitchGlaze_VIG_5pct_N_IQE0pt4.idf",
        "VeryHot_SwitchGlaze_VIG_5pct_N_IQE0pt6" => "../../../lib/resources/VeryHot_SwitchGlaze_VIG_5pct_N_IQE0pt6.idf",
        "VeryHot_SwitchGlaze_VIG_5pct_N_IQE0pt8" => "../../../lib/resources/VeryHot_SwitchGlaze_VIG_5pct_N_IQE0pt8.idf",
        "Hot_SwitchGlaze_VIG_5pct_N_IQE0" => "../../../lib/resources/Hot_SwitchGlaze_VIG_5pct_N_IQE0.idf",
        "Hot_SwitchGlaze_VIG_5pct_N_IQE0pt4" => "../../../lib/resources/Hot_SwitchGlaze_VIG_5pct_N_IQE0pt4.idf",
        "Hot_SwitchGlaze_VIG_5pct_N_IQE0pt6" => "../../../lib/resources/Hot_SwitchGlaze_VIG_5pct_N_IQE0pt6.idf",
        "Hot_SwitchGlaze_VIG_5pct_N_IQE0pt8" => "../../../lib/resources/Hot_SwitchGlaze_VIG_5pct_N_IQE0pt8.idf",
        "Cold_SwitchGlaze_VIG_5pct_N_IQE0" => "../../../lib/resources/Cold_SwitchGlaze_VIG_5pct_N_IQE0.idf",
        "Cold_SwitchGlaze_VIG_5pct_N_IQE0pt4" => "../../../lib/resources/Cold_SwitchGlaze_VIG_5pct_N_IQE0pt4.idf",
        "Cold_SwitchGlaze_VIG_5pct_N_IQE0pt6" => "../../../lib/resources/Cold_SwitchGlaze_VIG_5pct_N_IQE0pt6.idf",
        "Cold_SwitchGlaze_VIG_5pct_N_IQE0pt8" => "../../../lib/resources/Cold_SwitchGlaze_VIG_5pct_N_IQE0pt8.idf",
        "VeryCold_SwitchGlaze_VIG_5pct_N_IQE0" => "../../../lib/resources/VeryCold_SwitchGlaze_VIG_5pct_N_IQE0.idf",
        "VeryCold_SwitchGlaze_VIG_5pct_N_IQE0pt4" => "../../../lib/resources/VeryCold_SwitchGlaze_VIG_5pct_N_IQE0pt4.idf",
        "VeryCold_SwitchGlaze_VIG_5pct_N_IQE0pt6" => "../../../lib/resources/VeryCold_SwitchGlaze_VIG_5pct_N_IQE0pt6.idf",
        "VeryCold_SwitchGlaze_VIG_5pct_N_IQE0pt8" => "../../../lib/resources/VeryCold_SwitchGlaze_VIG_5pct_N_IQE0pt8.idf",
        "VeryCold_Triple_Tinted_25pct_N_IQE0" => "../../../lib/resources/VeryCold_Triple_Tinted_25pct_N_IQE0.idf",
        "VeryHot_Triple_Tinted_25pct_N_IQE0" => "../../../lib/resources/VeryHot_Triple_Tinted_25pct_N_IQE0.idf",
        "Cold_Triple_Tinted_25pct_N_IQE0" => "../../../lib/resources/Cold_Triple_Tinted_25pct_N_IQE0.idf",
        "Hot_Triple_Tinted_25pct_N_IQE0" => "../../../lib/resources/Hot_Triple_Tinted_25pct_N_IQE0.idf",
        "VeryCold_Triple_Tinted_50pct_N_IQE0" => "../../../lib/resources/VeryCold_Triple_Tinted_50pct_N_IQE0.idf",
        "VeryHot_Triple_Tinted_50pct_N_IQE0" => "../../../lib/resources/VeryHot_Triple_Tinted_50pct_N_IQE0.idf",
        "Cold_Triple_Tinted_50pct_N_IQE0" => "../../../lib/resources/Cold_Triple_Tinted_50pct_N_IQE0.idf",
        "Hot_Triple_Tinted_50pct_N_IQE0" => "../../../lib/resources/Hot_Triple_Tinted_50pct_N_IQE0.idf",
        "VeryCold_Triple_Tinted_50pct_S_IQE0" => "../../../lib/resources/VeryCold_Triple_Tinted_50pct_S_IQE0.idf",
        "VeryHot_Triple_Tinted_50pct_S_IQE0" => "../../../lib/resources/VeryHot_Triple_Tinted_50pct_S_IQE0.idf",
        "Cold_Triple_Tinted_50pct_S_IQE0" => "../../../lib/resources/Cold_Triple_Tinted_50pct_S_IQE0.idf",
        "Hot_Triple_Tinted_50pct_S_IQE0" => "../../../lib/resources/Hot_Triple_Tinted_50pct_S_IQE0.idf",
        "VeryCold_VIG_Tinted_25pct_N_IQE0" => "../../../lib/resources/VeryCold_VIG_Tinted_25pct_N_IQE0.idf",
        "VeryHot_VIG_Tinted_25pct_N_IQE0" => "../../../lib/resources/VeryHot_VIG_Tinted_25pct_N_IQE0.idf",
        "Cold_VIG_Tinted_25pct_N_IQE0" => "../../../lib/resources/Cold_VIG_Tinted_25pct_N_IQE0.idf",
        "Hot_VIG_Tinted_25pct_N_IQE0" => "../../../lib/resources/Hot_VIG_Tinted_25pct_N_IQE0.idf",
        "VeryCold_VIG_Tinted_50pct_N_IQE0" => "../../../lib/resources/VeryCold_VIG_Tinted_50pct_N_IQE0.idf",
        "VeryHot_VIG_Tinted_50pct_N_IQE0" => "../../../lib/resources/VeryHot_VIG_Tinted_50pct_N_IQE0.idf",
        "Cold_VIG_Tinted_50pct_N_IQE0" => "../../../lib/resources/Cold_VIG_Tinted_50pct_N_IQE0.idf",
        "Hot_VIG_Tinted_50pct_N_IQE0" => "../../../lib/resources/Hot_VIG_Tinted_50pct_N_IQE0.idf",
        "VeryCold_VIG_Tinted_50pct_S_IQE0" => "../../../lib/resources/VeryCold_VIG_Tinted_50pct_S_IQE0.idf",
        "VeryHot_VIG_Tinted_50pct_S_IQE0" => "../../../lib/resources/VeryHot_VIG_Tinted_50pct_S_IQE0.idf",
        "Cold_VIG_Tinted_50pct_S_IQE0" => "../../../lib/resources/Cold_VIG_Tinted_50pct_S_IQE0.idf",
        "Hot_VIG_Tinted_50pct_S_IQE0" => "../../../lib/resources/Hot_VIG_Tinted_50pct_S_IQE0.idf", 
        "VeryHot_Tinted_Triple_25pct_N_IQE0pt4" => "../../../lib/resources/VeryHot_Tinted_Triple_25pct_N_IQE0pt4.idf",
        "VeryHot_Tinted_Triple_25pct_N_IQE0pt6" => "../../../lib/resources/VeryHot_Tinted_Triple_25pct_N_IQE0pt6.idf",
        "VeryHot_Tinted_Triple_25pct_N_IQE0pt8" => "../../../lib/resources/VeryHot_Tinted_Triple_25pct_N_IQE0pt8.idf",
        "VeryHot_Tinted_Triple_50pct_N_IQE0pt4" => "../../../lib/resources/VeryHot_Tinted_Triple_50pct_N_IQE0pt4.idf",
        "VeryHot_Tinted_Triple_50pct_N_IQE0pt6" => "../../../lib/resources/VeryHot_Tinted_Triple_50pct_N_IQE0pt6.idf",
        "VeryHot_Tinted_Triple_50pct_N_IQE0pt8" => "../../../lib/resources/VeryHot_Tinted_Triple_50pct_N_IQE0pt8.idf",
        "VeryHot_Tinted_Triple_50pct_S_IQE0pt4" => "../../../lib/resources/VeryHot_Tinted_Triple_50pct_S_IQE0pt4.idf",
        "VeryHot_Tinted_Triple_50pct_S_IQE0pt6" => "../../../lib/resources/VeryHot_Tinted_Triple_50pct_S_IQE0pt6.idf",
        "VeryHot_Tinted_Triple_50pct_S_IQE0pt8" => "../../../lib/resources/VeryHot_Tinted_Triple_50pct_S_IQE0pt8.idf",
        "Hot_Tinted_Triple_25pct_N_IQE0pt4" => "../../../lib/resources/Hot_Tinted_Triple_25pct_N_IQE0pt4.idf",
        "Hot_Tinted_Triple_25pct_N_IQE0pt6" => "../../../lib/resources/Hot_Tinted_Triple_25pct_N_IQE0pt6.idf",
        "Hot_Tinted_Triple_25pct_N_IQE0pt8" => "../../../lib/resources/Hot_Tinted_Triple_25pct_N_IQE0pt8.idf",
        "Hot_Tinted_Triple_50pct_N_IQE0pt4" => "../../../lib/resources/Hot_Tinted_Triple_50pct_N_IQE0pt4.idf",
        "Hot_Tinted_Triple_50pct_N_IQE0pt6" => "../../../lib/resources/Hot_Tinted_Triple_50pct_N_IQE0pt6.idf",
        "Hot_Tinted_Triple_50pct_N_IQE0pt8" => "../../../lib/resources/Hot_Tinted_Triple_50pct_N_IQE0pt8.idf",
        "Hot_Tinted_Triple_50pct_S_IQE0pt4" => "../../../lib/resources/Hot_Tinted_Triple_50pct_S_IQE0pt4.idf",
        "Hot_Tinted_Triple_50pct_S_IQE0pt6" => "../../../lib/resources/Hot_Tinted_Triple_50pct_S_IQE0pt6.idf",
        "Hot_Tinted_Triple_50pct_S_IQE0pt8" => "../../../lib/resources/Hot_Tinted_Triple_50pct_S_IQE0pt8.idf",
        "Cold_Tinted_Triple_25pct_N_IQE0pt4" => "../../../lib/resources/Cold_Tinted_Triple_25pct_N_IQE0pt4.idf",
        "Cold_Tinted_Triple_25pct_N_IQE0pt6" => "../../../lib/resources/Cold_Tinted_Triple_25pct_N_IQE0pt6.idf",
        "Cold_Tinted_Triple_25pct_N_IQE0pt8" => "../../../lib/resources/Cold_Tinted_Triple_25pct_N_IQE0pt8.idf",
        "Cold_Tinted_Triple_50pct_N_IQE0pt4" => "../../../lib/resources/Cold_Tinted_Triple_50pct_N_IQE0pt4.idf",
        "Cold_Tinted_Triple_50pct_N_IQE0pt6" => "../../../lib/resources/Cold_Tinted_Triple_50pct_N_IQE0pt6.idf",
        "Cold_Tinted_Triple_50pct_N_IQE0pt8" => "../../../lib/resources/Cold_Tinted_Triple_50pct_N_IQE0pt8.idf",
        "Cold_Tinted_Triple_50pct_S_IQE0pt4" => "../../../lib/resources/Cold_Tinted_Triple_50pct_S_IQE0pt4.idf",
        "Cold_Tinted_Triple_50pct_S_IQE0pt6" => "../../../lib/resources/Cold_Tinted_Triple_50pct_S_IQE0pt6.idf",
        "Cold_Tinted_Triple_50pct_S_IQE0pt8" => "../../../lib/resources/Cold_Tinted_Triple_50pct_S_IQE0pt8.idf",
        "VeryCold_Tinted_Triple_25pct_N_IQE0pt4" => "../../../lib/resources/VeryCold_Tinted_Triple_25pct_N_IQE0pt4.idf",
        "VeryCold_Tinted_Triple_25pct_N_IQE0pt6" => "../../../lib/resources/VeryCold_Tinted_Triple_25pct_N_IQE0pt6.idf",
        "VeryCold_Tinted_Triple_25pct_N_IQE0pt8" => "../../../lib/resources/VeryCold_Tinted_Triple_25pct_N_IQE0pt8.idf",
        "VeryCold_Tinted_Triple_50pct_N_IQE0pt4" => "../../../lib/resources/VeryCold_Tinted_Triple_50pct_N_IQE0pt4.idf",
        "VeryCold_Tinted_Triple_50pct_N_IQE0pt6" => "../../../lib/resources/VeryCold_Tinted_Triple_50pct_N_IQE0pt6.idf",
        "VeryCold_Tinted_Triple_50pct_N_IQE0pt8" => "../../../lib/resources/VeryCold_Tinted_Triple_50pct_N_IQE0pt8.idf",
        "VeryCold_Tinted_Triple_50pct_S_IQE0pt4" => "../../../lib/resources/VeryCold_Tinted_Triple_50pct_S_IQE0pt4.idf",
        "VeryCold_Tinted_Triple_50pct_S_IQE0pt6" => "../../../lib/resources/VeryCold_Tinted_Triple_50pct_S_IQE0pt6.idf",
        "VeryCold_Tinted_Triple_50pct_S_IQE0pt8" => "../../../lib/resources/VeryCold_Tinted_Triple_50pct_S_IQE0pt8.idf",
        "VeryHot_Tinted_VIG_25pct_N_IQE0pt4" => "../../../lib/resources/VeryHot_Tinted_VIG_25pct_N_IQE0pt4.idf",
        "VeryHot_Tinted_VIG_25pct_N_IQE0pt6" => "../../../lib/resources/VeryHot_Tinted_VIG_25pct_N_IQE0pt6.idf",
        "VeryHot_Tinted_VIG_25pct_N_IQE0pt8" => "../../../lib/resources/VeryHot_Tinted_VIG_25pct_N_IQE0pt8.idf",
        "VeryHot_Tinted_VIG_50pct_N_IQE0pt4" => "../../../lib/resources/VeryHot_Tinted_VIG_50pct_N_IQE0pt4.idf",
        "VeryHot_Tinted_VIG_50pct_N_IQE0pt6" => "../../../lib/resources/VeryHot_Tinted_VIG_50pct_N_IQE0pt6.idf",
        "VeryHot_Tinted_VIG_50pct_N_IQE0pt8" => "../../../lib/resources/VeryHot_Tinted_VIG_50pct_N_IQE0pt8.idf",
        "VeryHot_Tinted_VIG_50pct_S_IQE0pt4" => "../../../lib/resources/VeryHot_Tinted_VIG_50pct_S_IQE0pt4.idf",
        "VeryHot_Tinted_VIG_50pct_S_IQE0pt6" => "../../../lib/resources/VeryHot_Tinted_VIG_50pct_S_IQE0pt6.idf",
        "VeryHot_Tinted_VIG_50pct_S_IQE0pt8" => "../../../lib/resources/VeryHot_Tinted_VIG_50pct_S_IQE0pt8.idf",
        "Hot_Tinted_VIG_25pct_N_IQE0pt4" => "../../../lib/resources/Hot_Tinted_VIG_25pct_N_IQE0pt4.idf",
        "Hot_Tinted_VIG_25pct_N_IQE0pt6" => "../../../lib/resources/Hot_Tinted_VIG_25pct_N_IQE0pt6.idf",
        "Hot_Tinted_VIG_25pct_N_IQE0pt8" => "../../../lib/resources/Hot_Tinted_VIG_25pct_N_IQE0pt8.idf",
        "Hot_Tinted_VIG_50pct_N_IQE0pt4" => "../../../lib/resources/Hot_Tinted_VIG_50pct_N_IQE0pt4.idf",
        "Hot_Tinted_VIG_50pct_N_IQE0pt6" => "../../../lib/resources/Hot_Tinted_VIG_50pct_N_IQE0pt6.idf",
        "Hot_Tinted_VIG_50pct_N_IQE0pt8" => "../../../lib/resources/Hot_Tinted_VIG_50pct_N_IQE0pt8.idf",
        "Hot_Tinted_VIG_50pct_S_IQE0pt4" => "../../../lib/resources/Hot_Tinted_VIG_50pct_S_IQE0pt4.idf",
        "Hot_Tinted_VIG_50pct_S_IQE0pt6" => "../../../lib/resources/Hot_Tinted_VIG_50pct_S_IQE0pt6.idf",
        "Hot_Tinted_VIG_50pct_S_IQE0pt8" => "../../../lib/resources/Hot_Tinted_VIG_50pct_S_IQE0pt8.idf",
        "Cold_Tinted_VIG_25pct_N_IQE0pt4" => "../../../lib/resources/Cold_Tinted_VIG_25pct_N_IQE0pt4.idf",
        "Cold_Tinted_VIG_25pct_N_IQE0pt6" => "../../../lib/resources/Cold_Tinted_VIG_25pct_N_IQE0pt6.idf",
        "Cold_Tinted_VIG_25pct_N_IQE0pt8" => "../../../lib/resources/Cold_Tinted_VIG_25pct_N_IQE0pt8.idf",
        "Cold_Tinted_VIG_50pct_N_IQE0pt4" => "../../../lib/resources/Cold_Tinted_VIG_50pct_N_IQE0pt4.idf",
        "Cold_Tinted_VIG_50pct_N_IQE0pt6" => "../../../lib/resources/Cold_Tinted_VIG_50pct_N_IQE0pt6.idf",
        "Cold_Tinted_VIG_50pct_N_IQE0pt8" => "../../../lib/resources/Cold_Tinted_VIG_50pct_N_IQE0pt8.idf",
        "Cold_Tinted_VIG_50pct_S_IQE0pt4" => "../../../lib/resources/Cold_Tinted_VIG_50pct_S_IQE0pt4.idf",
        "Cold_Tinted_VIG_50pct_S_IQE0pt6" => "../../../lib/resources/Cold_Tinted_VIG_50pct_S_IQE0pt6.idf",
        "Cold_Tinted_VIG_50pct_S_IQE0pt8" => "../../../lib/resources/Cold_Tinted_VIG_50pct_S_IQE0pt8.idf",
        "VeryCold_Tinted_VIG_25pct_N_IQE0pt4" => "../../../lib/resources/VeryCold_Tinted_VIG_25pct_N_IQE0pt4.idf",
        "VeryCold_Tinted_VIG_25pct_N_IQE0pt6" => "../../../lib/resources/VeryCold_Tinted_VIG_25pct_N_IQE0pt6.idf",
        "VeryCold_Tinted_VIG_25pct_N_IQE0pt8" => "../../../lib/resources/VeryCold_Tinted_VIG_25pct_N_IQE0pt8.idf",
        "VeryCold_Tinted_VIG_50pct_N_IQE0pt4" => "../../../lib/resources/VeryCold_Tinted_VIG_50pct_N_IQE0pt4.idf",
        "VeryCold_Tinted_VIG_50pct_N_IQE0pt6" => "../../../lib/resources/VeryCold_Tinted_VIG_50pct_N_IQE0pt6.idf",
        "VeryCold_Tinted_VIG_50pct_N_IQE0pt8" => "../../../lib/resources/VeryCold_Tinted_VIG_50pct_N_IQE0pt8.idf",
        "VeryCold_Tinted_VIG_50pct_S_IQE0pt4" => "../../../lib/resources/VeryCold_Tinted_VIG_50pct_S_IQE0pt4.idf",
        "VeryCold_Tinted_VIG_50pct_S_IQE0pt6" => "../../../lib/resources/VeryCold_Tinted_VIG_50pct_S_IQE0pt6.idf",
        "VeryCold_Tinted_VIG_50pct_S_IQE0pt8" => "../../../lib/resources/VeryCold_Tinted_VIG_50pct_S_IQE0pt8.idf",
      } 
    elsif serverrun == false
      runner.registerInfo("Reading idf files from the local #{idf_path} directory")
      dictionary = {
        "Baseline_GlzSys6" => "#{idf_path}/GlzSys_16095-air-9_Spec.idf",
        "Baseline_GlzSys13" => "#{idf_path}/GlzSys_6374-air-3000_Spec.idf",
        "Baseline_GlzSys15" => "#{idf_path}/GlzSys_10F-air-3000_Spec.idf",
        "Baseline_GlzSys15_withPV" => "#{idf_path}/GlzSys21_13F-air-3000_Spec.idf",
        "Baseline_GlzSys6_13" => "#{idf_path}/GlzSys_16095-air-3000_Spec.idf",
        "GlzSys_6_withoutPV" => "#{idf_path}/GlzSys_10-air-9_Spec.idf",
        "GlzSys_13_withoutPV" => "#{idf_path}/GlzSys_11F-air-3000_Spec.idf",
        "GlzSys_6_withPV" => "#{idf_path}/GlzSys19_13F-air-9_Spec.idf",
        "GlzSys_13_withPV" => "#{idf_path}/GlzSys20_14F-air-3000_Spec.idf",
        "VeryHot_SwitchGlaze" => "#{idf_path}/SG_zone12_Spec.idf",
        "Hot_SwitchGlaze" => "#{idf_path}/SG_zone3_Spec.idf",
        "Cold_SwitchGlaze" => "#{idf_path}/SG_zone456_Spec.idf",
        "VeryCold_SwitchGlaze" => "#{idf_path}/SG_zone78_Spec.idf",
        "VeryHot_Dark" => "#{idf_path}/dark_zone12_Spec.idf",
        "VeryHot_Light" => "#{idf_path}/light_zone12_Spec.idf",
        "Hot_Dark" => "#{idf_path}/dark_zone3_Spec.idf",
        "Hot_Light" => "#{idf_path}/light_zone3_Spec.idf", 
        "Cold_Dark" => "#{idf_path}/dark_zone456_Spec.idf",
        "Cold_Light" => "#{idf_path}/light_zone456_Spec.idf",
        "VeryCold_Dark" => "#{idf_path}/dark_zone78_Spec.idf",
        "VeryCold_Light" => "#{idf_path}/light_zone78_Spec.idf", 
        "Cold_ASHRAE" => "#{idf_path}/Cold_ASHRAE.idf",
        "Cold_Bleached_0pt5pct_N_IQE0" => "#{idf_path}/Cold_Bleached_0pt5pct_N_IQE0.idf",
        "Cold_Bleached_0pt5pct_N_IQE0pt4" => "#{idf_path}/Cold_Bleached_0pt5pct_N_IQE0pt4.idf",
        "Cold_Bleached_0pt5pct_N_IQE0pt6" => "#{idf_path}/Cold_Bleached_0pt5pct_N_IQE0pt6.idf",
        "Cold_Bleached_0pt5pct_N_IQE0pt8" => "#{idf_path}/Cold_Bleached_0pt5pct_N_IQE0pt8.idf",
        "Cold_Bleached_5pct_N_IQE0" => "#{idf_path}/Cold_Bleached_5pct_N_IQE0.idf",
        "Cold_Bleached_5pct_N_IQE0pt4" => "#{idf_path}/Cold_Bleached_5pct_N_IQE0pt4.idf",
        "Cold_Bleached_5pct_N_IQE0pt6" => "#{idf_path}/Cold_Bleached_5pct_N_IQE0pt6.idf",
        "Cold_Bleached_5pct_N_IQE0pt8" => "#{idf_path}/Cold_Bleached_5pct_N_IQE0pt8.idf",
        "Cold_SwitchGlaze_0pt5pct_N_IQE0" => "#{idf_path}/Cold_SwitchGlaze_0pt5pct_N_IQE0.idf",
        "Cold_SwitchGlaze_0pt5pct_N_IQE0pt4" => "#{idf_path}/Cold_SwitchGlaze_0pt5pct_N_IQE0pt4.idf",
        "Cold_SwitchGlaze_0pt5pct_N_IQE0pt6" => "#{idf_path}/Cold_SwitchGlaze_0pt5pct_N_IQE0pt6.idf",
        "Cold_SwitchGlaze_0pt5pct_N_IQE0pt8" => "#{idf_path}/Cold_SwitchGlaze_0pt5pct_N_IQE0pt8.idf",
        "Cold_SwitchGlaze_5pct_N_IQE0" => "#{idf_path}/Cold_SwitchGlaze_5pct_N_IQE0.idf",
        "Cold_SwitchGlaze_5pct_N_IQE0pt4" => "#{idf_path}/Cold_SwitchGlaze_5pct_N_IQE0pt4.idf",
        "Cold_SwitchGlaze_5pct_N_IQE0pt6" => "#{idf_path}/Cold_SwitchGlaze_5pct_N_IQE0pt6.idf",
        "Cold_SwitchGlaze_5pct_N_IQE0pt8" => "#{idf_path}/Cold_SwitchGlaze_5pct_N_IQE0pt8.idf",
        "Cold_SwitchGlaze_25pct_N_IQE0" => "#{idf_path}/Cold_SwitchGlaze_25pct_N_IQE0.idf",
        "Cold_SwitchGlaze_25pct_N_IQE0pt4" => "#{idf_path}/Cold_SwitchGlaze_25pct_N_IQE0pt4.idf",
        "Cold_SwitchGlaze_25pct_N_IQE0pt6" => "#{idf_path}/Cold_SwitchGlaze_25pct_N_IQE0pt6.idf",
        "Cold_SwitchGlaze_25pct_N_IQE0pt8" => "#{idf_path}/Cold_SwitchGlaze_25pct_N_IQE0pt8.idf",
        "Cold_Tinted_0pt5pct_N_IQE0" => "#{idf_path}/Cold_Tinted_0pt5pct_N_IQE0.idf",
        "Cold_Tinted_0pt5pct_N_IQE0pt4" => "#{idf_path}/Cold_Tinted_0pt5pct_N_IQE0pt4.idf",
        "Cold_Tinted_0pt5pct_N_IQE0pt6" => "#{idf_path}/Cold_Tinted_0pt5pct_N_IQE0pt6.idf",
        "Cold_Tinted_0pt5pct_N_IQE0pt8" => "#{idf_path}/Cold_Tinted_0pt5pct_N_IQE0pt8.idf",
        "Cold_Tinted_25pct_N_IQE0" => "#{idf_path}/Cold_Tinted_25pct_N_IQE0.idf",
        "Cold_Tinted_25pct_N_IQE0pt4" => "#{idf_path}/Cold_Tinted_25pct_N_IQE0pt4.idf",
        "Cold_Tinted_25pct_N_IQE0pt6" => "#{idf_path}/Cold_Tinted_25pct_N_IQE0pt6.idf",
        "Cold_Tinted_25pct_N_IQE0pt8" => "#{idf_path}/Cold_Tinted_25pct_N_IQE0pt8.idf",
        "Cold_Tinted_50pct_N_IQE0" => "#{idf_path}/Cold_Tinted_50pct_N_IQE0.idf",
        "Cold_Tinted_50pct_N_IQE0pt4" => "#{idf_path}/Cold_Tinted_50pct_N_IQE0pt4.idf",
        "Cold_Tinted_50pct_N_IQE0pt6" => "#{idf_path}/Cold_Tinted_50pct_N_IQE0pt6.idf",
        "Cold_Tinted_50pct_N_IQE0pt8" => "#{idf_path}/Cold_Tinted_50pct_N_IQE0pt8.idf",
        "Cold_Tinted_50pct_S_IQE0" => "#{idf_path}/Cold_Tinted_50pct_S_IQE0.idf",
        "Cold_Tinted_50pct_S_IQE0pt4" => "#{idf_path}/Cold_Tinted_50pct_S_IQE0pt4.idf",
        "Cold_Tinted_50pct_S_IQE0pt6" => "#{idf_path}/Cold_Tinted_50pct_S_IQE0pt6.idf",
        "Cold_Tinted_50pct_S_IQE0pt8" => "#{idf_path}/Cold_Tinted_50pct_S_IQE0pt8.idf",
        "Cold_Tinted_5pct_N_IQE0" => "#{idf_path}/Cold_Tinted_5pct_N_IQE0.idf",
        "Cold_Tinted_5pct_N_IQE0pt4" => "#{idf_path}/Cold_Tinted_5pct_N_IQE0pt4.idf",
        "Cold_Tinted_5pct_N_IQE0pt6" => "#{idf_path}/Cold_Tinted_5pct_N_IQE0pt6.idf",
        "Cold_Tinted_5pct_N_IQE0pt8" => "#{idf_path}/Cold_Tinted_5pct_N_IQE0pt8.idf",
        "Double_Pane" => "#{idf_path}/Double_Pane.idf",
        "Hot_ASHRAE" => "#{idf_path}/Hot_ASHRAE.idf",
        "Hot_Bleached_0pt5pct_N_IQE0" => "#{idf_path}/Hot_Bleached_0pt5pct_N_IQE0.idf",
        "Hot_Bleached_0pt5pct_N_IQE0pt4" => "#{idf_path}/Hot_Bleached_0pt5pct_N_IQE0pt4.idf",
        "Hot_Bleached_0pt5pct_N_IQE0pt6" => "#{idf_path}/Hot_Bleached_0pt5pct_N_IQE0pt6.idf",
        "Hot_Bleached_0pt5pct_N_IQE0pt8" => "#{idf_path}/Hot_Bleached_0pt5pct_N_IQE0pt8.idf",
        "Hot_Bleached_5pct_N_IQE0" => "#{idf_path}/Hot_Bleached_5pct_N_IQE0.idf",
        "Hot_Bleached_5pct_N_IQE0pt4" => "#{idf_path}/Hot_Bleached_5pct_N_IQE0pt4.idf",
        "Hot_Bleached_5pct_N_IQE0pt6" => "#{idf_path}/Hot_Bleached_5pct_N_IQE0pt6.idf",
        "Hot_Bleached_5pct_N_IQE0pt8" => "#{idf_path}/Hot_Bleached_5pct_N_IQE0pt8.idf",
        "Hot_SwitchGlaze_0pt5pct_N_IQE0" => "#{idf_path}/Hot_SwitchGlaze_0pt5pct_N_IQE0.idf",
        "Hot_SwitchGlaze_0pt5pct_N_IQE0pt4" => "#{idf_path}/Hot_SwitchGlaze_0pt5pct_N_IQE0pt4.idf",
        "Hot_SwitchGlaze_0pt5pct_N_IQE0pt6" => "#{idf_path}/Hot_SwitchGlaze_0pt5pct_N_IQE0pt6.idf",
        "Hot_SwitchGlaze_0pt5pct_N_IQE0pt8" => "#{idf_path}/Hot_SwitchGlaze_0pt5pct_N_IQE0pt8.idf",
        "Hot_SwitchGlaze_5pct_N_IQE0" => "#{idf_path}/Hot_SwitchGlaze_5pct_N_IQE0.idf",
        "Hot_SwitchGlaze_5pct_N_IQE0pt4" => "#{idf_path}/Hot_SwitchGlaze_5pct_N_IQE0pt4.idf",
        "Hot_SwitchGlaze_5pct_N_IQE0pt6" => "#{idf_path}/Hot_SwitchGlaze_5pct_N_IQE0pt6.idf",
        "Hot_SwitchGlaze_5pct_N_IQE0pt8" => "#{idf_path}/Hot_SwitchGlaze_5pct_N_IQE0pt8.idf",
        "Hot_SwitchGlaze_25pct_N_IQE0" => "#{idf_path}/Hot_SwitchGlaze_25pct_N_IQE0.idf",
        "Hot_SwitchGlaze_25pct_N_IQE0pt4" => "#{idf_path}/Hot_SwitchGlaze_25pct_N_IQE0pt4.idf",
        "Hot_SwitchGlaze_25pct_N_IQE0pt6" => "#{idf_path}/Hot_SwitchGlaze_25pct_N_IQE0pt6.idf",
        "Hot_SwitchGlaze_25pct_N_IQE0pt8" => "#{idf_path}/Hot_SwitchGlaze_25pct_N_IQE0pt8.idf",
        "Hot_Tinted_0pt5pct_N_IQE0" => "#{idf_path}/Hot_Tinted_0pt5pct_N_IQE0.idf",
        "Hot_Tinted_0pt5pct_N_IQE0pt4" => "#{idf_path}/Hot_Tinted_0pt5pct_N_IQE0pt4.idf",
        "Hot_Tinted_0pt5pct_N_IQE0pt6" => "#{idf_path}/Hot_Tinted_0pt5pct_N_IQE0pt6.idf",
        "Hot_Tinted_0pt5pct_N_IQE0pt8" => "#{idf_path}/Hot_Tinted_0pt5pct_N_IQE0pt8.idf",
        "Hot_Tinted_25pct_N_IQE0" => "#{idf_path}/Hot_Tinted_25pct_N_IQE0.idf",
        "Hot_Tinted_25pct_N_IQE0pt4" => "#{idf_path}/Hot_Tinted_25pct_N_IQE0pt4.idf",
        "Hot_Tinted_25pct_N_IQE0pt6" => "#{idf_path}/Hot_Tinted_25pct_N_IQE0pt6.idf",
        "Hot_Tinted_25pct_N_IQE0pt8" => "#{idf_path}/Hot_Tinted_25pct_N_IQE0pt8.idf",
        "Hot_Tinted_50pct_N_IQE0" => "#{idf_path}/Hot_Tinted_50pct_N_IQE0.idf",
        "Hot_Tinted_50pct_N_IQE0pt4" => "#{idf_path}/Hot_Tinted_50pct_N_IQE0pt4.idf",
        "Hot_Tinted_50pct_N_IQE0pt6" => "#{idf_path}/Hot_Tinted_50pct_N_IQE0pt6.idf",
        "Hot_Tinted_50pct_N_IQE0pt8" => "#{idf_path}/Hot_Tinted_50pct_N_IQE0pt8.idf",
        "Hot_Tinted_50pct_S_IQE0" => "#{idf_path}/Hot_Tinted_50pct_S_IQE0.idf",
        "Hot_Tinted_50pct_S_IQE0pt4" => "#{idf_path}/Hot_Tinted_50pct_S_IQE0pt4.idf",
        "Hot_Tinted_50pct_S_IQE0pt6" => "#{idf_path}/Hot_Tinted_50pct_S_IQE0pt6.idf",
        "Hot_Tinted_50pct_S_IQE0pt8" => "#{idf_path}/Hot_Tinted_50pct_S_IQE0pt8.idf",
        "Hot_Tinted_5pct_N_IQE0" => "#{idf_path}/Hot_Tinted_5pct_N_IQE0.idf",
        "Hot_Tinted_5pct_N_IQE0pt4" => "#{idf_path}/Hot_Tinted_5pct_N_IQE0pt4.idf",
        "Hot_Tinted_5pct_N_IQE0pt6" => "#{idf_path}/Hot_Tinted_5pct_N_IQE0pt6.idf",
        "Hot_Tinted_5pct_N_IQE0pt8" => "#{idf_path}/Hot_Tinted_5pct_N_IQE0pt8.idf",
        "Single_Pane" => "#{idf_path}/Single_Pane.idf",
        "VeryCold_ASHRAE" => "#{idf_path}/VeryCold_ASHRAE.idf",
        "VeryCold_Bleached_0pt5pct_N_IQE0" => "#{idf_path}/VeryCold_Bleached_0pt5pct_N_IQE0.idf",
        "VeryCold_Bleached_0pt5pct_N_IQE0pt4" => "#{idf_path}/VeryCold_Bleached_0pt5pct_N_IQE0pt4.idf",
        "VeryCold_Bleached_0pt5pct_N_IQE0pt6" => "#{idf_path}/VeryCold_Bleached_0pt5pct_N_IQE0pt6.idf",
        "VeryCold_Bleached_0pt5pct_N_IQE0pt8" => "#{idf_path}/VeryCold_Bleached_0pt5pct_N_IQE0pt8.idf",
        "VeryCold_Bleached_5pct_N_IQE0" => "#{idf_path}/VeryCold_Bleached_5pct_N_IQE0.idf",
        "VeryCold_Bleached_5pct_N_IQE0pt4" => "#{idf_path}/VeryCold_Bleached_5pct_N_IQE0pt4.idf",
        "VeryCold_Bleached_5pct_N_IQE0pt6" => "#{idf_path}/VeryCold_Bleached_5pct_N_IQE0pt6.idf",
        "VeryCold_Bleached_5pct_N_IQE0pt8" => "#{idf_path}/VeryCold_Bleached_5pct_N_IQE0pt8.idf",
        "VeryCold_SwitchGlaze_0pt5pct_N_IQE0" => "#{idf_path}/VeryCold_SwitchGlaze_0pt5pct_N_IQE0.idf",
        "VeryCold_SwitchGlaze_0pt5pct_N_IQE0pt4" => "#{idf_path}/VeryCold_SwitchGlaze_0pt5pct_N_IQE0pt4.idf",
        "VeryCold_SwitchGlaze_0pt5pct_N_IQE0pt6" => "#{idf_path}/VeryCold_SwitchGlaze_0pt5pct_N_IQE0pt6.idf",
        "VeryCold_SwitchGlaze_0pt5pct_N_IQE0pt8" => "#{idf_path}/VeryCold_SwitchGlaze_0pt5pct_N_IQE0pt8.idf",
        "VeryCold_SwitchGlaze_5pct_N_IQE0" => "#{idf_path}/VeryCold_SwitchGlaze_5pct_N_IQE0.idf",
        "VeryCold_SwitchGlaze_5pct_N_IQE0pt4" => "#{idf_path}/VeryCold_SwitchGlaze_5pct_N_IQE0pt4.idf",
        "VeryCold_SwitchGlaze_5pct_N_IQE0pt6" => "#{idf_path}/VeryCold_SwitchGlaze_5pct_N_IQE0pt6.idf",
        "VeryCold_SwitchGlaze_5pct_N_IQE0pt8" => "#{idf_path}/VeryCold_SwitchGlaze_5pct_N_IQE0pt8.idf",
        "VeryCold_SwitchGlaze_25pct_N_IQE0" => "#{idf_path}/VeryCold_SwitchGlaze_25pct_N_IQE0.idf",
        "VeryCold_SwitchGlaze_25pct_N_IQE0pt4" => "#{idf_path}/VeryCold_SwitchGlaze_25pct_N_IQE0pt4.idf",
        "VeryCold_SwitchGlaze_25pct_N_IQE0pt6" => "#{idf_path}/VeryCold_SwitchGlaze_25pct_N_IQE0pt6.idf",
        "VeryCold_SwitchGlaze_25pct_N_IQE0pt8" => "#{idf_path}/VeryCold_SwitchGlaze_25pct_N_IQE0pt8.idf",
        "VeryCold_Tinted_0pt5pct_N_IQE0" => "#{idf_path}/VeryCold_Tinted_0pt5pct_N_IQE0.idf",
        "VeryCold_Tinted_0pt5pct_N_IQE0pt4" => "#{idf_path}/VeryCold_Tinted_0pt5pct_N_IQE0pt4.idf",
        "VeryCold_Tinted_0pt5pct_N_IQE0pt6" => "#{idf_path}/VeryCold_Tinted_0pt5pct_N_IQE0pt6.idf",
        "VeryCold_Tinted_0pt5pct_N_IQE0pt8" => "#{idf_path}/VeryCold_Tinted_0pt5pct_N_IQE0pt8.idf",
        "VeryCold_Tinted_25pct_N_IQE0" => "#{idf_path}/VeryCold_Tinted_25pct_N_IQE0.idf",
        "VeryCold_Tinted_25pct_N_IQE0pt4" => "#{idf_path}/VeryCold_Tinted_25pct_N_IQE0pt4.idf",
        "VeryCold_Tinted_25pct_N_IQE0pt6" => "#{idf_path}/VeryCold_Tinted_25pct_N_IQE0pt6.idf",
        "VeryCold_Tinted_25pct_N_IQE0pt8" => "#{idf_path}/VeryCold_Tinted_25pct_N_IQE0pt8.idf",
        "VeryCold_Tinted_50pct_N_IQE0" => "#{idf_path}/VeryCold_Tinted_50pct_N_IQE0.idf",
        "VeryCold_Tinted_50pct_N_IQE0pt4" => "#{idf_path}/VeryCold_Tinted_50pct_N_IQE0pt4.idf",
        "VeryCold_Tinted_50pct_N_IQE0pt6" => "#{idf_path}/VeryCold_Tinted_50pct_N_IQE0pt6.idf",
        "VeryCold_Tinted_50pct_N_IQE0pt8" => "#{idf_path}/VeryCold_Tinted_50pct_N_IQE0pt8.idf",
        "VeryCold_Tinted_50pct_S_IQE0" => "#{idf_path}/VeryCold_Tinted_50pct_S_IQE0.idf",
        "VeryCold_Tinted_50pct_S_IQE0pt4" => "#{idf_path}/VeryCold_Tinted_50pct_S_IQE0pt4.idf",
        "VeryCold_Tinted_50pct_S_IQE0pt6" => "#{idf_path}/VeryCold_Tinted_50pct_S_IQE0pt6.idf",
        "VeryCold_Tinted_50pct_S_IQE0pt8" => "#{idf_path}/VeryCold_Tinted_50pct_S_IQE0pt8.idf",
        "VeryCold_Tinted_5pct_N_IQE0" => "#{idf_path}/VeryCold_Tinted_5pct_N_IQE0.idf",
        "VeryCold_Tinted_5pct_N_IQE0pt4" => "#{idf_path}/VeryCold_Tinted_5pct_N_IQE0pt4.idf",
        "VeryCold_Tinted_5pct_N_IQE0pt6" => "#{idf_path}/VeryCold_Tinted_5pct_N_IQE0pt6.idf",
        "VeryCold_Tinted_5pct_N_IQE0pt8" => "#{idf_path}/VeryCold_Tinted_5pct_N_IQE0pt8.idf",
        "VeryHot_ASHRAE" => "#{idf_path}/VeryHot_ASHRAE.idf",
        "VeryHot_Bleached_0pt5pct_N_IQE0" => "#{idf_path}/VeryHot_Bleached_0pt5pct_N_IQE0.idf",
        "VeryHot_Bleached_0pt5pct_N_IQE0pt4" => "#{idf_path}/VeryHot_Bleached_0pt5pct_N_IQE0pt4.idf",
        "VeryHot_Bleached_0pt5pct_N_IQE0pt6" => "#{idf_path}/VeryHot_Bleached_0pt5pct_N_IQE0pt6.idf",
        "VeryHot_Bleached_0pt5pct_N_IQE0pt8" => "#{idf_path}/VeryHot_Bleached_0pt5pct_N_IQE0pt8.idf",
        "VeryHot_Bleached_5pct_N_IQE0" => "#{idf_path}/VeryHot_Bleached_5pct_N_IQE0.idf",
        "VeryHot_Bleached_5pct_N_IQE0pt4" => "#{idf_path}/VeryHot_Bleached_5pct_N_IQE0pt4.idf",
        "VeryHot_Bleached_5pct_N_IQE0pt6" => "#{idf_path}/VeryHot_Bleached_5pct_N_IQE0pt6.idf",
        "VeryHot_Bleached_5pct_N_IQE0pt8" => "#{idf_path}/VeryHot_Bleached_5pct_N_IQE0pt8.idf",
        "VeryHot_SwitchGlaze_0pt5pct_N_IQE0" => "#{idf_path}/VeryHot_SwitchGlaze_0pt5pct_N_IQE0.idf",
        "VeryHot_SwitchGlaze_0pt5pct_N_IQE0pt4" => "#{idf_path}/VeryHot_SwitchGlaze_0pt5pct_N_IQE0pt4.idf",
        "VeryHot_SwitchGlaze_0pt5pct_N_IQE0pt6" => "#{idf_path}/VeryHot_SwitchGlaze_0pt5pct_N_IQE0pt6.idf",
        "VeryHot_SwitchGlaze_0pt5pct_N_IQE0pt8" => "#{idf_path}/VeryHot_SwitchGlaze_0pt5pct_N_IQE0pt8.idf",
        "VeryHot_SwitchGlaze_5pct_N_IQE0" => "#{idf_path}/VeryHot_SwitchGlaze_5pct_N_IQE0.idf",
        "VeryHot_SwitchGlaze_5pct_N_IQE0pt4" => "#{idf_path}/VeryHot_SwitchGlaze_5pct_N_IQE0pt4.idf",
        "VeryHot_SwitchGlaze_5pct_N_IQE0pt6" => "#{idf_path}/VeryHot_SwitchGlaze_5pct_N_IQE0pt6.idf",
        "VeryHot_SwitchGlaze_5pct_N_IQE0pt8" => "#{idf_path}/VeryHot_SwitchGlaze_5pct_N_IQE0pt8.idf",
        "VeryHot_SwitchGlaze_25pct_N_IQE0" => "#{idf_path}/VeryHot_SwitchGlaze_25pct_N_IQE0.idf",
        "VeryHot_SwitchGlaze_25pct_N_IQE0pt4" => "#{idf_path}/VeryHot_SwitchGlaze_25pct_N_IQE0pt4.idf",
        "VeryHot_SwitchGlaze_25pct_N_IQE0pt6" => "#{idf_path}/VeryHot_SwitchGlaze_25pct_N_IQE0pt6.idf",
        "VeryHot_SwitchGlaze_25pct_N_IQE0pt8" => "#{idf_path}/VeryHot_SwitchGlaze_25pct_N_IQE0pt8.idf",
        "VeryHot_Tinted_0pt5pct_N_IQE0" => "#{idf_path}/VeryHot_Tinted_0pt5pct_N_IQE0.idf",
        "VeryHot_Tinted_0pt5pct_N_IQE0pt4" => "#{idf_path}/VeryHot_Tinted_0pt5pct_N_IQE0pt4.idf",
        "VeryHot_Tinted_0pt5pct_N_IQE0pt6" => "#{idf_path}/VeryHot_Tinted_0pt5pct_N_IQE0pt6.idf",
        "VeryHot_Tinted_0pt5pct_N_IQE0pt8" => "#{idf_path}/VeryHot_Tinted_0pt5pct_N_IQE0pt8.idf",
        "VeryHot_Tinted_25pct_N_IQE0" => "#{idf_path}/VeryHot_Tinted_25pct_N_IQE0.idf",
        "VeryHot_Tinted_25pct_N_IQE0pt4" => "#{idf_path}/VeryHot_Tinted_25pct_N_IQE0pt4.idf",
        "VeryHot_Tinted_25pct_N_IQE0pt6" => "#{idf_path}/VeryHot_Tinted_25pct_N_IQE0pt6.idf",
        "VeryHot_Tinted_25pct_N_IQE0pt8" => "#{idf_path}/VeryHot_Tinted_25pct_N_IQE0pt8.idf",
        "VeryHot_Tinted_50pct_N_IQE0" => "#{idf_path}/VeryHot_Tinted_50pct_N_IQE0.idf",
        "VeryHot_Tinted_50pct_N_IQE0pt4" => "#{idf_path}/VeryHot_Tinted_50pct_N_IQE0pt4.idf",
        "VeryHot_Tinted_50pct_N_IQE0pt6" => "#{idf_path}/VeryHot_Tinted_50pct_N_IQE0pt6.idf",
        "VeryHot_Tinted_50pct_N_IQE0pt8" => "#{idf_path}/VeryHot_Tinted_50pct_N_IQE0pt8.idf",
        "VeryHot_Tinted_50pct_S_IQE0" => "#{idf_path}/VeryHot_Tinted_50pct_S_IQE0.idf",
        "VeryHot_Tinted_50pct_S_IQE0pt4" => "#{idf_path}/VeryHot_Tinted_50pct_S_IQE0pt4.idf",
        "VeryHot_Tinted_50pct_S_IQE0pt6" => "#{idf_path}/VeryHot_Tinted_50pct_S_IQE0pt6.idf",
        "VeryHot_Tinted_50pct_S_IQE0pt8" => "#{idf_path}/VeryHot_Tinted_50pct_S_IQE0pt8.idf",
        "VeryHot_Tinted_5pct_N_IQE0" => "#{idf_path}/VeryHot_Tinted_5pct_N_IQE0.idf",
        "VeryHot_Tinted_5pct_N_IQE0pt4" => "#{idf_path}/VeryHot_Tinted_5pct_N_IQE0pt4.idf",
        "VeryHot_Tinted_5pct_N_IQE0pt6" => "#{idf_path}/VeryHot_Tinted_5pct_N_IQE0pt6.idf",
        "VeryHot_Tinted_5pct_N_IQE0pt8" => "#{idf_path}/VeryHot_Tinted_5pct_N_IQE0pt8.idf",
        "Cold_SwitchGlaze_10pct_N_IQE0pt4" => "#{idf_path}/Cold_SwitchGlaze_10pct_N_IQE0pt4.idf",
        "Cold_SwitchGlaze_10pct_N_IQE0pt6" => "#{idf_path}/Cold_SwitchGlaze_10pct_N_IQE0pt6.idf",
        "Cold_SwitchGlaze_10pct_N_IQE0pt8" => "#{idf_path}/Cold_SwitchGlaze_10pct_N_IQE0pt8.idf",
        "Cold_SwitchGlaze_15pct_N_IQE0pt4" => "#{idf_path}/Cold_SwitchGlaze_15pct_N_IQE0pt4.idf",
        "Cold_SwitchGlaze_15pct_N_IQE0pt6" => "#{idf_path}/Cold_SwitchGlaze_15pct_N_IQE0pt6.idf",
        "Cold_SwitchGlaze_15pct_N_IQE0pt8" => "#{idf_path}/Cold_SwitchGlaze_15pct_N_IQE0pt8.idf",
        "Cold_SwitchGlaze_20pct_N_IQE0pt4" => "#{idf_path}/Cold_SwitchGlaze_20pct_N_IQE0pt4.idf",
        "Cold_SwitchGlaze_20pct_N_IQE0pt6" => "#{idf_path}/Cold_SwitchGlaze_20pct_N_IQE0pt6.idf",
        "Cold_SwitchGlaze_20pct_N_IQE0pt8" => "#{idf_path}/Cold_SwitchGlaze_20pct_N_IQE0pt8.idf",
        "Hot_SwitchGlaze_10pct_N_IQE0pt4" => "#{idf_path}/Hot_SwitchGlaze_10pct_N_IQE0pt4.idf",
        "Hot_SwitchGlaze_10pct_N_IQE0pt6" => "#{idf_path}/Hot_SwitchGlaze_10pct_N_IQE0pt6.idf",
        "Hot_SwitchGlaze_10pct_N_IQE0pt8" => "#{idf_path}/Hot_SwitchGlaze_10pct_N_IQE0pt8.idf",
        "Hot_SwitchGlaze_15pct_N_IQE0pt4" => "#{idf_path}/Hot_SwitchGlaze_15pct_N_IQE0pt4.idf",
        "Hot_SwitchGlaze_15pct_N_IQE0pt6" => "#{idf_path}/Hot_SwitchGlaze_15pct_N_IQE0pt6.idf",
        "Hot_SwitchGlaze_15pct_N_IQE0pt8" => "#{idf_path}/Hot_SwitchGlaze_15pct_N_IQE0pt8.idf",
        "Hot_SwitchGlaze_20pct_N_IQE0pt4" => "#{idf_path}/Hot_SwitchGlaze_20pct_N_IQE0pt4.idf",
        "Hot_SwitchGlaze_20pct_N_IQE0pt6" => "#{idf_path}/Hot_SwitchGlaze_20pct_N_IQE0pt6.idf",
        "Hot_SwitchGlaze_20pct_N_IQE0pt8" => "#{idf_path}/Hot_SwitchGlaze_20pct_N_IQE0pt8.idf",
        "VeryCold_SwitchGlaze_10pct_N_IQE0pt4" => "#{idf_path}/VeryCold_SwitchGlaze_10pct_N_IQE0pt4.idf",
        "VeryCold_SwitchGlaze_10pct_N_IQE0pt6" => "#{idf_path}/VeryCold_SwitchGlaze_10pct_N_IQE0pt6.idf",
        "VeryCold_SwitchGlaze_10pct_N_IQE0pt8" => "#{idf_path}/VeryCold_SwitchGlaze_10pct_N_IQE0pt8.idf",
        "VeryCold_SwitchGlaze_15pct_N_IQE0pt4" => "#{idf_path}/VeryCold_SwitchGlaze_15pct_N_IQE0pt4.idf",
        "VeryCold_SwitchGlaze_15pct_N_IQE0pt6" => "#{idf_path}/VeryCold_SwitchGlaze_15pct_N_IQE0pt6.idf",
        "VeryCold_SwitchGlaze_15pct_N_IQE0pt8" => "#{idf_path}/VeryCold_SwitchGlaze_15pct_N_IQE0pt8.idf",
        "VeryCold_SwitchGlaze_20pct_N_IQE0pt4" => "#{idf_path}/VeryCold_SwitchGlaze_20pct_N_IQE0pt4.idf",
        "VeryCold_SwitchGlaze_20pct_N_IQE0pt6" => "#{idf_path}/VeryCold_SwitchGlaze_20pct_N_IQE0pt6.idf",
        "VeryCold_SwitchGlaze_20pct_N_IQE0pt8" => "#{idf_path}/VeryCold_SwitchGlaze_20pct_N_IQE0pt8.idf",
        "VeryHot_SwitchGlaze_10pct_N_IQE0pt4" => "#{idf_path}/VeryHot_SwitchGlaze_10pct_N_IQE0pt4.idf",
        "VeryHot_SwitchGlaze_10pct_N_IQE0pt6" => "#{idf_path}/VeryHot_SwitchGlaze_10pct_N_IQE0pt6.idf",
        "VeryHot_SwitchGlaze_10pct_N_IQE0pt8" => "#{idf_path}/VeryHot_SwitchGlaze_10pct_N_IQE0pt8.idf",
        "VeryHot_SwitchGlaze_15pct_N_IQE0pt4" => "#{idf_path}/VeryHot_SwitchGlaze_15pct_N_IQE0pt4.idf",
        "VeryHot_SwitchGlaze_15pct_N_IQE0pt6" => "#{idf_path}/VeryHot_SwitchGlaze_15pct_N_IQE0pt6.idf",
        "VeryHot_SwitchGlaze_15pct_N_IQE0pt8" => "#{idf_path}/VeryHot_SwitchGlaze_15pct_N_IQE0pt8.idf",
        "VeryHot_SwitchGlaze_20pct_N_IQE0pt4" => "#{idf_path}/VeryHot_SwitchGlaze_20pct_N_IQE0pt4.idf",
        "VeryHot_SwitchGlaze_20pct_N_IQE0pt6" => "#{idf_path}/VeryHot_SwitchGlaze_20pct_N_IQE0pt6.idf",
        "VeryHot_SwitchGlaze_20pct_N_IQE0pt8" => "#{idf_path}/VeryHot_SwitchGlaze_20pct_N_IQE0pt8.idf",
        "VeryHot_Triple_Pane" => "#{idf_path}/VeryHot_Triple_Pane.idf",
        "Hot_Triple_Pane" => "#{idf_path}/Hot_Triple_Pane.idf",
        "Cold_Triple_Pane" => "#{idf_path}/Cold_Triple_Pane.idf",
        "VeryCold_Triple_Pane" => "#{idf_path}/VeryCold_Triple_Pane.idf",
        "VeryHot_VIG" => "#{idf_path}/VeryHot_VIG.idf",
        "Hot_VIG" => "#{idf_path}/Hot_VIG.idf",
        "Cold_VIG" => "#{idf_path}/Cold_VIG.idf",
        "VeryCold_VIG" => "#{idf_path}/VeryCold_VIG.idf",
        "VeryHot_SwitchGlaze_Triple_0pt5pct_N_IQE0" => "#{idf_path}/VeryHot_SwitchGlaze_Triple_0pt5pct_N_IQE0.idf",
        "VeryHot_SwitchGlaze_Triple_0pt5pct_N_IQE0pt4" => "#{idf_path}/VeryHot_SwitchGlaze_Triple_0pt5pct_N_IQE0pt4.idf",
        "VeryHot_SwitchGlaze_Triple_0pt5pct_N_IQE0pt6" => "#{idf_path}/VeryHot_SwitchGlaze_Triple_0pt5pct_N_IQE0pt6.idf",
        "VeryHot_SwitchGlaze_Triple_0pt5pct_N_IQE0pt8" => "#{idf_path}/VeryHot_SwitchGlaze_Triple_0pt5pct_N_IQE0pt8.idf",
        "Hot_SwitchGlaze_Triple_0pt5pct_N_IQE0" => "#{idf_path}/Hot_SwitchGlaze_Triple_0pt5pct_N_IQE0.idf",
        "Hot_SwitchGlaze_Triple_0pt5pct_N_IQE0pt4" => "#{idf_path}/Hot_SwitchGlaze_Triple_0pt5pct_N_IQE0pt4.idf",
        "Hot_SwitchGlaze_Triple_0pt5pct_N_IQE0pt6" => "#{idf_path}/Hot_SwitchGlaze_Triple_0pt5pct_N_IQE0pt6.idf",
        "Hot_SwitchGlaze_Triple_0pt5pct_N_IQE0pt8" => "#{idf_path}/Hot_SwitchGlaze_Triple_0pt5pct_N_IQE0pt8.idf",
        "Cold_SwitchGlaze_Triple_0pt5pct_N_IQE0" => "#{idf_path}/Cold_SwitchGlaze_Triple_0pt5pct_N_IQE0.idf",
        "Cold_SwitchGlaze_Triple_0pt5pct_N_IQE0pt4" => "#{idf_path}/Cold_SwitchGlaze_Triple_0pt5pct_N_IQE0pt4.idf",
        "Cold_SwitchGlaze_Triple_0pt5pct_N_IQE0pt6" => "#{idf_path}/Cold_SwitchGlaze_Triple_0pt5pct_N_IQE0pt6.idf",
        "Cold_SwitchGlaze_Triple_0pt5pct_N_IQE0pt8" => "#{idf_path}/Cold_SwitchGlaze_Triple_0pt5pct_N_IQE0pt8.idf",
        "VeryCold_SwitchGlaze_Triple_0pt5pct_N_IQE0" => "#{idf_path}/VeryCold_SwitchGlaze_Triple_0pt5pct_N_IQE0.idf",
        "VeryCold_SwitchGlaze_Triple_0pt5pct_N_IQE0pt4" => "#{idf_path}/VeryCold_SwitchGlaze_Triple_0pt5pct_N_IQE0pt4.idf",
        "VeryCold_SwitchGlaze_Triple_0pt5pct_N_IQE0pt6" => "#{idf_path}/VeryCold_SwitchGlaze_Triple_0pt5pct_N_IQE0pt6.idf",
        "VeryCold_SwitchGlaze_Triple_0pt5pct_N_IQE0pt8" => "#{idf_path}/VeryCold_SwitchGlaze_Triple_0pt5pct_N_IQE0pt8.idf",
        "VeryHot_SwitchGlaze_Triple_5pct_N_IQE0" => "#{idf_path}/VeryHot_SwitchGlaze_Triple_5pct_N_IQE0.idf",
        "VeryHot_SwitchGlaze_Triple_5pct_N_IQE0pt4" => "#{idf_path}/VeryHot_SwitchGlaze_Triple_5pct_N_IQE0pt4.idf",
        "VeryHot_SwitchGlaze_Triple_5pct_N_IQE0pt6" => "#{idf_path}/VeryHot_SwitchGlaze_Triple_5pct_N_IQE0pt6.idf",
        "VeryHot_SwitchGlaze_Triple_5pct_N_IQE0pt8" => "#{idf_path}/VeryHot_SwitchGlaze_Triple_5pct_N_IQE0pt8.idf",
        "Hot_SwitchGlaze_Triple_5pct_N_IQE0" => "#{idf_path}/Hot_SwitchGlaze_Triple_5pct_N_IQE0.idf",
        "Hot_SwitchGlaze_Triple_5pct_N_IQE0pt4" => "#{idf_path}/Hot_SwitchGlaze_Triple_5pct_N_IQE0pt4.idf",
        "Hot_SwitchGlaze_Triple_5pct_N_IQE0pt6" => "#{idf_path}/Hot_SwitchGlaze_Triple_5pct_N_IQE0pt6.idf",
        "Hot_SwitchGlaze_Triple_5pct_N_IQE0pt8" => "#{idf_path}/Hot_SwitchGlaze_Triple_5pct_N_IQE0pt8.idf",
        "Cold_SwitchGlaze_Triple_5pct_N_IQE0" => "#{idf_path}/Cold_SwitchGlaze_Triple_5pct_N_IQE0.idf",
        "Cold_SwitchGlaze_Triple_5pct_N_IQE0pt4" => "#{idf_path}/Cold_SwitchGlaze_Triple_5pct_N_IQE0pt4.idf",
        "Cold_SwitchGlaze_Triple_5pct_N_IQE0pt6" => "#{idf_path}/Cold_SwitchGlaze_Triple_5pct_N_IQE0pt6.idf",
        "Cold_SwitchGlaze_Triple_5pct_N_IQE0pt8" => "#{idf_path}/Cold_SwitchGlaze_Triple_5pct_N_IQE0pt8.idf",
        "VeryCold_SwitchGlaze_Triple_5pct_N_IQE0" => "#{idf_path}/VeryCold_SwitchGlaze_Triple_5pct_N_IQE0.idf",
        "VeryCold_SwitchGlaze_Triple_5pct_N_IQE0pt4" => "#{idf_path}/VeryCold_SwitchGlaze_Triple_5pct_N_IQE0pt4.idf",
        "VeryCold_SwitchGlaze_Triple_5pct_N_IQE0pt6" => "#{idf_path}/VeryCold_SwitchGlaze_Triple_5pct_N_IQE0pt6.idf",
        "VeryCold_SwitchGlaze_Triple_5pct_N_IQE0pt8" => "#{idf_path}/VeryCold_SwitchGlaze_Triple_5pct_N_IQE0pt8.idf",
        "VeryHot_SwitchGlaze_VIG_0pt5pct_N_IQE0" => "#{idf_path}/VeryHot_SwitchGlaze_VIG_0pt5pct_N_IQE0.idf",
        "VeryHot_SwitchGlaze_VIG_0pt5pct_N_IQE0pt4" => "#{idf_path}/VeryHot_SwitchGlaze_VIG_0pt5pct_N_IQE0pt4.idf",
        "VeryHot_SwitchGlaze_VIG_0pt5pct_N_IQE0pt6" => "#{idf_path}/VeryHot_SwitchGlaze_VIG_0pt5pct_N_IQE0pt6.idf",
        "VeryHot_SwitchGlaze_VIG_0pt5pct_N_IQE0pt8" => "#{idf_path}/VeryHot_SwitchGlaze_VIG_0pt5pct_N_IQE0pt8.idf",
        "Hot_SwitchGlaze_VIG_0pt5pct_N_IQE0" => "#{idf_path}/Hot_SwitchGlaze_VIG_0pt5pct_N_IQE0.idf",
        "Hot_SwitchGlaze_VIG_0pt5pct_N_IQE0pt4" => "#{idf_path}/Hot_SwitchGlaze_VIG_0pt5pct_N_IQE0pt4.idf",
        "Hot_SwitchGlaze_VIG_0pt5pct_N_IQE0pt6" => "#{idf_path}/Hot_SwitchGlaze_VIG_0pt5pct_N_IQE0pt6.idf",
        "Hot_SwitchGlaze_VIG_0pt5pct_N_IQE0pt8" => "#{idf_path}/Hot_SwitchGlaze_VIG_0pt5pct_N_IQE0pt8.idf",
        "Cold_SwitchGlaze_VIG_0pt5pct_N_IQE0" => "#{idf_path}/Cold_SwitchGlaze_VIG_0pt5pct_N_IQE0.idf",
        "Cold_SwitchGlaze_VIG_0pt5pct_N_IQE0pt4" => "#{idf_path}/Cold_SwitchGlaze_VIG_0pt5pct_N_IQE0pt4.idf",
        "Cold_SwitchGlaze_VIG_0pt5pct_N_IQE0pt6" => "#{idf_path}/Cold_SwitchGlaze_VIG_0pt5pct_N_IQE0pt6.idf",
        "Cold_SwitchGlaze_VIG_0pt5pct_N_IQE0pt8" => "#{idf_path}/Cold_SwitchGlaze_VIG_0pt5pct_N_IQE0pt8.idf",
        "VeryCold_SwitchGlaze_VIG_0pt5pct_N_IQE0" => "#{idf_path}/VeryCold_SwitchGlaze_VIG_0pt5pct_N_IQE0.idf",
        "VeryCold_SwitchGlaze_VIG_0pt5pct_N_IQE0pt4" => "#{idf_path}/VeryCold_SwitchGlaze_VIG_0pt5pct_N_IQE0pt4.idf",
        "VeryCold_SwitchGlaze_VIG_0pt5pct_N_IQE0pt6" => "#{idf_path}/VeryCold_SwitchGlaze_VIG_0pt5pct_N_IQE0pt6.idf",
        "VeryCold_SwitchGlaze_VIG_0pt5pct_N_IQE0pt8" => "#{idf_path}/VeryCold_SwitchGlaze_VIG_0pt5pct_N_IQE0pt8.idf",
        "VeryHot_SwitchGlaze_VIG_5pct_N_IQE0" => "#{idf_path}/VeryHot_SwitchGlaze_VIG_5pct_N_IQE0.idf",
        "VeryHot_SwitchGlaze_VIG_5pct_N_IQE0pt4" => "#{idf_path}/VeryHot_SwitchGlaze_VIG_5pct_N_IQE0pt4.idf",
        "VeryHot_SwitchGlaze_VIG_5pct_N_IQE0pt6" => "#{idf_path}/VeryHot_SwitchGlaze_VIG_5pct_N_IQE0pt6.idf",
        "VeryHot_SwitchGlaze_VIG_5pct_N_IQE0pt8" => "#{idf_path}/VeryHot_SwitchGlaze_VIG_5pct_N_IQE0pt8.idf",
        "Hot_SwitchGlaze_VIG_5pct_N_IQE0" => "#{idf_path}/Hot_SwitchGlaze_VIG_5pct_N_IQE0.idf",
        "Hot_SwitchGlaze_VIG_5pct_N_IQE0pt4" => "#{idf_path}/Hot_SwitchGlaze_VIG_5pct_N_IQE0pt4.idf",
        "Hot_SwitchGlaze_VIG_5pct_N_IQE0pt6" => "#{idf_path}/Hot_SwitchGlaze_VIG_5pct_N_IQE0pt6.idf",
        "Hot_SwitchGlaze_VIG_5pct_N_IQE0pt8" => "#{idf_path}/Hot_SwitchGlaze_VIG_5pct_N_IQE0pt8.idf",
        "Cold_SwitchGlaze_VIG_5pct_N_IQE0" => "#{idf_path}/Cold_SwitchGlaze_VIG_5pct_N_IQE0.idf",
        "Cold_SwitchGlaze_VIG_5pct_N_IQE0pt4" => "#{idf_path}/Cold_SwitchGlaze_VIG_5pct_N_IQE0pt4.idf",
        "Cold_SwitchGlaze_VIG_5pct_N_IQE0pt6" => "#{idf_path}/Cold_SwitchGlaze_VIG_5pct_N_IQE0pt6.idf",
        "Cold_SwitchGlaze_VIG_5pct_N_IQE0pt8" => "#{idf_path}/Cold_SwitchGlaze_VIG_5pct_N_IQE0pt8.idf",
        "VeryCold_SwitchGlaze_VIG_5pct_N_IQE0" => "#{idf_path}/VeryCold_SwitchGlaze_VIG_5pct_N_IQE0.idf",
        "VeryCold_SwitchGlaze_VIG_5pct_N_IQE0pt4" => "#{idf_path}/VeryCold_SwitchGlaze_VIG_5pct_N_IQE0pt4.idf",
        "VeryCold_SwitchGlaze_VIG_5pct_N_IQE0pt6" => "#{idf_path}/VeryCold_SwitchGlaze_VIG_5pct_N_IQE0pt6.idf",
        "VeryCold_SwitchGlaze_VIG_5pct_N_IQE0pt8" => "#{idf_path}/VeryCold_SwitchGlaze_VIG_5pct_N_IQE0pt8.idf",
        "VeryCold_Triple_Tinted_25pct_N_IQE0" => "#{idf_path}/VeryCold_Triple_Tinted_25pct_N_IQE0.idf",
        "VeryHot_Triple_Tinted_25pct_N_IQE0" => "#{idf_path}/VeryHot_Triple_Tinted_25pct_N_IQE0.idf",
        "Cold_Triple_Tinted_25pct_N_IQE0" => "#{idf_path}/Cold_Triple_Tinted_25pct_N_IQE0.idf",
        "Hot_Triple_Tinted_25pct_N_IQE0" => "#{idf_path}/Hot_Triple_Tinted_25pct_N_IQE0.idf",
        "VeryCold_Triple_Tinted_50pct_N_IQE0" => "#{idf_path}/VeryCold_Triple_Tinted_50pct_N_IQE0.idf",
        "VeryHot_Triple_Tinted_50pct_N_IQE0" => "#{idf_path}/VeryHot_Triple_Tinted_50pct_N_IQE0.idf",
        "Cold_Triple_Tinted_50pct_N_IQE0" => "#{idf_path}/Cold_Triple_Tinted_50pct_N_IQE0.idf",
        "Hot_Triple_Tinted_50pct_N_IQE0" => "#{idf_path}/Hot_Triple_Tinted_50pct_N_IQE0.idf",
        "VeryCold_Triple_Tinted_50pct_S_IQE0" => "#{idf_path}/VeryCold_Triple_Tinted_50pct_S_IQE0.idf",
        "VeryHot_Triple_Tinted_50pct_S_IQE0" => "#{idf_path}/VeryHot_Triple_Tinted_50pct_S_IQE0.idf",
        "Cold_Triple_Tinted_50pct_S_IQE0" => "#{idf_path}/Cold_Triple_Tinted_50pct_S_IQE0.idf",
        "Hot_Triple_Tinted_50pct_S_IQE0" => "#{idf_path}/Hot_Triple_Tinted_50pct_S_IQE0.idf",
        "VeryCold_VIG_Tinted_25pct_N_IQE0" => "#{idf_path}/VeryCold_VIG_Tinted_25pct_N_IQE0.idf",
        "VeryHot_VIG_Tinted_25pct_N_IQE0" => "#{idf_path}/VeryHot_VIG_Tinted_25pct_N_IQE0.idf",
        "Cold_VIG_Tinted_25pct_N_IQE0" => "#{idf_path}/Cold_VIG_Tinted_25pct_N_IQE0.idf",
        "Hot_VIG_Tinted_25pct_N_IQE0" => "#{idf_path}/Hot_VIG_Tinted_25pct_N_IQE0.idf",
        "VeryCold_VIG_Tinted_50pct_N_IQE0" => "#{idf_path}/VeryCold_VIG_Tinted_50pct_N_IQE0.idf",
        "VeryHot_VIG_Tinted_50pct_N_IQE0" => "#{idf_path}/VeryHot_VIG_Tinted_50pct_N_IQE0.idf",
        "Cold_VIG_Tinted_50pct_N_IQE0" => "#{idf_path}/Cold_VIG_Tinted_50pct_N_IQE0.idf",
        "Hot_VIG_Tinted_50pct_N_IQE0" => "#{idf_path}/Hot_VIG_Tinted_50pct_N_IQE0.idf",
        "VeryCold_VIG_Tinted_50pct_S_IQE0" => "#{idf_path}/VeryCold_VIG_Tinted_50pct_S_IQE0.idf",
        "VeryHot_VIG_Tinted_50pct_S_IQE0" => "#{idf_path}/VeryHot_VIG_Tinted_50pct_S_IQE0.idf",
        "Cold_VIG_Tinted_50pct_S_IQE0" => "#{idf_path}/Cold_VIG_Tinted_50pct_S_IQE0.idf",
        "Hot_VIG_Tinted_50pct_S_IQE0" => "#{idf_path}/Hot_VIG_Tinted_50pct_S_IQE0.idf",
        "VeryHot_Tinted_Triple_25pct_N_IQE0pt4" => "#{idf_path}/VeryHot_Tinted_Triple_25pct_N_IQE0pt4.idf",
        "VeryHot_Tinted_Triple_25pct_N_IQE0pt6" => "#{idf_path}/VeryHot_Tinted_Triple_25pct_N_IQE0pt6.idf",
        "VeryHot_Tinted_Triple_25pct_N_IQE0pt8" => "#{idf_path}/VeryHot_Tinted_Triple_25pct_N_IQE0pt8.idf",
        "VeryHot_Tinted_Triple_50pct_N_IQE0pt4" => "#{idf_path}/VeryHot_Tinted_Triple_50pct_N_IQE0pt4.idf",
        "VeryHot_Tinted_Triple_50pct_N_IQE0pt6" => "#{idf_path}/VeryHot_Tinted_Triple_50pct_N_IQE0pt6.idf",
        "VeryHot_Tinted_Triple_50pct_N_IQE0pt8" => "#{idf_path}/VeryHot_Tinted_Triple_50pct_N_IQE0pt8.idf",
        "VeryHot_Tinted_Triple_50pct_S_IQE0pt4" => "#{idf_path}/VeryHot_Tinted_Triple_50pct_S_IQE0pt4.idf",
        "VeryHot_Tinted_Triple_50pct_S_IQE0pt6" => "#{idf_path}/VeryHot_Tinted_Triple_50pct_S_IQE0pt6.idf",
        "VeryHot_Tinted_Triple_50pct_S_IQE0pt8" => "#{idf_path}/VeryHot_Tinted_Triple_50pct_S_IQE0pt8.idf",
        "Hot_Tinted_Triple_25pct_N_IQE0pt4" => "#{idf_path}/Hot_Tinted_Triple_25pct_N_IQE0pt4.idf",
        "Hot_Tinted_Triple_25pct_N_IQE0pt6" => "#{idf_path}/Hot_Tinted_Triple_25pct_N_IQE0pt6.idf",
        "Hot_Tinted_Triple_25pct_N_IQE0pt8" => "#{idf_path}/Hot_Tinted_Triple_25pct_N_IQE0pt8.idf",
        "Hot_Tinted_Triple_50pct_N_IQE0pt4" => "#{idf_path}/Hot_Tinted_Triple_50pct_N_IQE0pt4.idf",
        "Hot_Tinted_Triple_50pct_N_IQE0pt6" => "#{idf_path}/Hot_Tinted_Triple_50pct_N_IQE0pt6.idf",
        "Hot_Tinted_Triple_50pct_N_IQE0pt8" => "#{idf_path}/Hot_Tinted_Triple_50pct_N_IQE0pt8.idf",
        "Hot_Tinted_Triple_50pct_S_IQE0pt4" => "#{idf_path}/Hot_Tinted_Triple_50pct_S_IQE0pt4.idf",
        "Hot_Tinted_Triple_50pct_S_IQE0pt6" => "#{idf_path}/Hot_Tinted_Triple_50pct_S_IQE0pt6.idf",
        "Hot_Tinted_Triple_50pct_S_IQE0pt8" => "#{idf_path}/Hot_Tinted_Triple_50pct_S_IQE0pt8.idf",
        "Cold_Tinted_Triple_25pct_N_IQE0pt4" => "#{idf_path}/Cold_Tinted_Triple_25pct_N_IQE0pt4.idf",
        "Cold_Tinted_Triple_25pct_N_IQE0pt6" => "#{idf_path}/Cold_Tinted_Triple_25pct_N_IQE0pt6.idf",
        "Cold_Tinted_Triple_25pct_N_IQE0pt8" => "#{idf_path}/Cold_Tinted_Triple_25pct_N_IQE0pt8.idf",
        "Cold_Tinted_Triple_50pct_N_IQE0pt4" => "#{idf_path}/Cold_Tinted_Triple_50pct_N_IQE0pt4.idf",
        "Cold_Tinted_Triple_50pct_N_IQE0pt6" => "#{idf_path}/Cold_Tinted_Triple_50pct_N_IQE0pt6.idf",
        "Cold_Tinted_Triple_50pct_N_IQE0pt8" => "#{idf_path}/Cold_Tinted_Triple_50pct_N_IQE0pt8.idf",
        "Cold_Tinted_Triple_50pct_S_IQE0pt4" => "#{idf_path}/Cold_Tinted_Triple_50pct_S_IQE0pt4.idf",
        "Cold_Tinted_Triple_50pct_S_IQE0pt6" => "#{idf_path}/Cold_Tinted_Triple_50pct_S_IQE0pt6.idf",
        "Cold_Tinted_Triple_50pct_S_IQE0pt8" => "#{idf_path}/Cold_Tinted_Triple_50pct_S_IQE0pt8.idf",
        "VeryCold_Tinted_Triple_25pct_N_IQE0pt4" => "#{idf_path}/VeryCold_Tinted_Triple_25pct_N_IQE0pt4.idf",
        "VeryCold_Tinted_Triple_25pct_N_IQE0pt6" => "#{idf_path}/VeryCold_Tinted_Triple_25pct_N_IQE0pt6.idf",
        "VeryCold_Tinted_Triple_25pct_N_IQE0pt8" => "#{idf_path}/VeryCold_Tinted_Triple_25pct_N_IQE0pt8.idf",
        "VeryCold_Tinted_Triple_50pct_N_IQE0pt4" => "#{idf_path}/VeryCold_Tinted_Triple_50pct_N_IQE0pt4.idf",
        "VeryCold_Tinted_Triple_50pct_N_IQE0pt6" => "#{idf_path}/VeryCold_Tinted_Triple_50pct_N_IQE0pt6.idf",
        "VeryCold_Tinted_Triple_50pct_N_IQE0pt8" => "#{idf_path}/VeryCold_Tinted_Triple_50pct_N_IQE0pt8.idf",
        "VeryCold_Tinted_Triple_50pct_S_IQE0pt4" => "#{idf_path}/VeryCold_Tinted_Triple_50pct_S_IQE0pt4.idf",
        "VeryCold_Tinted_Triple_50pct_S_IQE0pt6" => "#{idf_path}/VeryCold_Tinted_Triple_50pct_S_IQE0pt6.idf",
        "VeryCold_Tinted_Triple_50pct_S_IQE0pt8" => "#{idf_path}/VeryCold_Tinted_Triple_50pct_S_IQE0pt8.idf",
        "VeryHot_Tinted_VIG_25pct_N_IQE0pt4" => "#{idf_path}/VeryHot_Tinted_VIG_25pct_N_IQE0pt4.idf",
        "VeryHot_Tinted_VIG_25pct_N_IQE0pt6" => "#{idf_path}/VeryHot_Tinted_VIG_25pct_N_IQE0pt6.idf",
        "VeryHot_Tinted_VIG_25pct_N_IQE0pt8" => "#{idf_path}/VeryHot_Tinted_VIG_25pct_N_IQE0pt8.idf",
        "VeryHot_Tinted_VIG_50pct_N_IQE0pt4" => "#{idf_path}/VeryHot_Tinted_VIG_50pct_N_IQE0pt4.idf",
        "VeryHot_Tinted_VIG_50pct_N_IQE0pt6" => "#{idf_path}/VeryHot_Tinted_VIG_50pct_N_IQE0pt6.idf",
        "VeryHot_Tinted_VIG_50pct_N_IQE0pt8" => "#{idf_path}/VeryHot_Tinted_VIG_50pct_N_IQE0pt8.idf",
        "VeryHot_Tinted_VIG_50pct_S_IQE0pt4" => "#{idf_path}/VeryHot_Tinted_VIG_50pct_S_IQE0pt4.idf",
        "VeryHot_Tinted_VIG_50pct_S_IQE0pt6" => "#{idf_path}/VeryHot_Tinted_VIG_50pct_S_IQE0pt6.idf",
        "VeryHot_Tinted_VIG_50pct_S_IQE0pt8" => "#{idf_path}/VeryHot_Tinted_VIG_50pct_S_IQE0pt8.idf",
        "Hot_Tinted_VIG_25pct_N_IQE0pt4" => "#{idf_path}/Hot_Tinted_VIG_25pct_N_IQE0pt4.idf",
        "Hot_Tinted_VIG_25pct_N_IQE0pt6" => "#{idf_path}/Hot_Tinted_VIG_25pct_N_IQE0pt6.idf",
        "Hot_Tinted_VIG_25pct_N_IQE0pt8" => "#{idf_path}/Hot_Tinted_VIG_25pct_N_IQE0pt8.idf",
        "Hot_Tinted_VIG_50pct_N_IQE0pt4" => "#{idf_path}/Hot_Tinted_VIG_50pct_N_IQE0pt4.idf",
        "Hot_Tinted_VIG_50pct_N_IQE0pt6" => "#{idf_path}/Hot_Tinted_VIG_50pct_N_IQE0pt6.idf",
        "Hot_Tinted_VIG_50pct_N_IQE0pt8" => "#{idf_path}/Hot_Tinted_VIG_50pct_N_IQE0pt8.idf",
        "Hot_Tinted_VIG_50pct_S_IQE0pt4" => "#{idf_path}/Hot_Tinted_VIG_50pct_S_IQE0pt4.idf",
        "Hot_Tinted_VIG_50pct_S_IQE0pt6" => "#{idf_path}/Hot_Tinted_VIG_50pct_S_IQE0pt6.idf",
        "Hot_Tinted_VIG_50pct_S_IQE0pt8" => "#{idf_path}/Hot_Tinted_VIG_50pct_S_IQE0pt8.idf",
        "Cold_Tinted_VIG_25pct_N_IQE0pt4" => "#{idf_path}/Cold_Tinted_VIG_25pct_N_IQE0pt4.idf",
        "Cold_Tinted_VIG_25pct_N_IQE0pt6" => "#{idf_path}/Cold_Tinted_VIG_25pct_N_IQE0pt6.idf",
        "Cold_Tinted_VIG_25pct_N_IQE0pt8" => "#{idf_path}/Cold_Tinted_VIG_25pct_N_IQE0pt8.idf",
        "Cold_Tinted_VIG_50pct_N_IQE0pt4" => "#{idf_path}/Cold_Tinted_VIG_50pct_N_IQE0pt4.idf",
        "Cold_Tinted_VIG_50pct_N_IQE0pt6" => "#{idf_path}/Cold_Tinted_VIG_50pct_N_IQE0pt6.idf",
        "Cold_Tinted_VIG_50pct_N_IQE0pt8" => "#{idf_path}/Cold_Tinted_VIG_50pct_N_IQE0pt8.idf",
        "Cold_Tinted_VIG_50pct_S_IQE0pt4" => "#{idf_path}/Cold_Tinted_VIG_50pct_S_IQE0pt4.idf",
        "Cold_Tinted_VIG_50pct_S_IQE0pt6" => "#{idf_path}/Cold_Tinted_VIG_50pct_S_IQE0pt6.idf",
        "Cold_Tinted_VIG_50pct_S_IQE0pt8" => "#{idf_path}/Cold_Tinted_VIG_50pct_S_IQE0pt8.idf",
        "VeryCold_Tinted_VIG_25pct_N_IQE0pt4" => "#{idf_path}/VeryCold_Tinted_VIG_25pct_N_IQE0pt4.idf",
        "VeryCold_Tinted_VIG_25pct_N_IQE0pt6" => "#{idf_path}/VeryCold_Tinted_VIG_25pct_N_IQE0pt6.idf",
        "VeryCold_Tinted_VIG_25pct_N_IQE0pt8" => "#{idf_path}/VeryCold_Tinted_VIG_25pct_N_IQE0pt8.idf",
        "VeryCold_Tinted_VIG_50pct_N_IQE0pt4" => "#{idf_path}/VeryCold_Tinted_VIG_50pct_N_IQE0pt4.idf",
        "VeryCold_Tinted_VIG_50pct_N_IQE0pt6" => "#{idf_path}/VeryCold_Tinted_VIG_50pct_N_IQE0pt6.idf",
        "VeryCold_Tinted_VIG_50pct_N_IQE0pt8" => "#{idf_path}/VeryCold_Tinted_VIG_50pct_N_IQE0pt8.idf",
        "VeryCold_Tinted_VIG_50pct_S_IQE0pt4" => "#{idf_path}/VeryCold_Tinted_VIG_50pct_S_IQE0pt4.idf",
        "VeryCold_Tinted_VIG_50pct_S_IQE0pt6" => "#{idf_path}/VeryCold_Tinted_VIG_50pct_S_IQE0pt6.idf",
        "VeryCold_Tinted_VIG_50pct_S_IQE0pt8" => "#{idf_path}/VeryCold_Tinted_VIG_50pct_S_IQE0pt8.idf",
      } 
    end
    ####################################################################################
    ####################################################################################
      

    # report initial condition
    runner.registerInitialCondition("The initial IDF file had #{workspace.objects.size} objects.")

    # load IDF
    runner.registerInfo("Reading window idf from: #{dictionary[glztype]}")
    source_idf = OpenStudio::IdfFile::load(OpenStudio::Path.new(dictionary[glztype])).get

    # add everything from the file
    workspace.addObjects(source_idf.objects)    

    runner.registerInitialCondition("Imposing fenestration construction name change on #{choice} surface(s).")
 
    ####################################################################################
    #find the fenestration surface to change
    ####################################################################################
    
    no_found = true
    applicable = true
    fenestrationsurfaces = workspace.getObjectsByType("FenestrationSurface:Detailed".to_IddObjectType)
    fenestrationsurfaces.each do |fenestrationsurface|
    
      if choice == "inferred"
        no_found = false
        ###############################################################
        # getting vertices for window surfaces
        ###############################################################
        v1x=fenestrationsurface.getString(9).get.to_f
        v1y=fenestrationsurface.getString(10).get.to_f
        v1z=fenestrationsurface.getString(11).get.to_f
        v2x=fenestrationsurface.getString(12).get.to_f
        v2y=fenestrationsurface.getString(13).get.to_f
        v2z=fenestrationsurface.getString(14).get.to_f
        # v3x=fenestrationsurface.getString(15).get.to_f
        # v3y=fenestrationsurface.getString(16).get.to_f
        # v3z=fenestrationsurface.getString(17).get.to_f
        v4x=fenestrationsurface.getString(18).get.to_f
        v4y=fenestrationsurface.getString(19).get.to_f
        v4z=fenestrationsurface.getString(20).get.to_f
        ###############################################################
        # surface normal calculation for determining surface orientation between East, North, South, and West
        ###############################################################
        u_x = v2x - v1x
        u_y = v2y - v1y
        u_z = v2z - v1z
        w_x = v4x - v1x
        w_y = v4y - v1y
        w_z = v4z - v1z
        surfacenormal_x = u_y*w_z - u_z*w_y
        surfacenormal_y = u_z*w_x - u_x*w_z
        runner.registerInfo("surfacenormal_x = #{surfacenormal_x}")
        runner.registerInfo("surfacenormal_y = #{surfacenormal_y}")
        surfacenormal_orientation=''
        if (surfacenormal_x>0) && (surfacenormal_y==0)
          surfacenormal_orientation = "E"
        elsif (surfacenormal_x<0) && (surfacenormal_y==0)
          surfacenormal_orientation = "W"
        elsif (surfacenormal_x==0) && (surfacenormal_y>0)
          surfacenormal_orientation = "N"
        elsif (surfacenormal_x==0) && (surfacenormal_y<0)
          surfacenormal_orientation = "S"
        elsif
          false
        end
        runner.registerInfo("surfacenormal_orientation = #{surfacenormal_orientation}")
        ###############################################################
        if pv_orientation.to_s.eql?("S") && (surfacenormal_orientation.to_s.eql?("S"))
          runner.registerInfo("Replacing window on #{fenestrationsurface.getString(0).to_s} which is on #{pv_orientation} orientation") 
          runner.registerInfo("Changing [#{fenestrationsurface.getString(2)}] to [#{glztype}]")
          fenestrationsurface.setString(2,glztype)
        elsif pv_orientation.to_s.eql?("E") && (surfacenormal_orientation.to_s.eql?("E"))
          runner.registerInfo("Replacing window on #{fenestrationsurface.getString(0).to_s} which is on #{pv_orientation} orientation") 
          runner.registerInfo("Changing [#{fenestrationsurface.getString(2)}] to [#{glztype}]")
          fenestrationsurface.setString(2,glztype)
        elsif pv_orientation.to_s.eql?("N") && (surfacenormal_orientation.to_s.eql?("N"))
          runner.registerInfo("Replacing window on #{fenestrationsurface.getString(0).to_s} which is on #{pv_orientation} orientation") 
          runner.registerInfo("Changing [#{fenestrationsurface.getString(2)}] to [#{glztype}]")
          fenestrationsurface.setString(2,glztype)
        elsif pv_orientation.to_s.eql?("W") && (surfacenormal_orientation.to_s.eql?("W"))
          runner.registerInfo("Replacing window on #{fenestrationsurface.getString(0).to_s} which is on #{pv_orientation} orientation") 
          runner.registerInfo("Changing [#{fenestrationsurface.getString(2)}] to [#{glztype}]")
          fenestrationsurface.setString(2,glztype)
        elsif pv_orientation.to_s.eql?("ESW") && !(surfacenormal_orientation.to_s.eql?("N"))
          runner.registerInfo("Replacing window on #{fenestrationsurface.getString(0).to_s} which is on #{pv_orientation} orientation") 
          runner.registerInfo("Changing [#{fenestrationsurface.getString(2)}] to [#{glztype}]")
          fenestrationsurface.setString(2,glztype)
        elsif pv_orientation.to_s.eql?("NONE")
          #do nothing
        elsif pv_orientation.to_s.eql?("ALL")
          runner.registerInfo("Replacing window on #{fenestrationsurface.getString(0).to_s}") 
          runner.registerInfo("Changing [#{fenestrationsurface.getString(2)}] to [#{glztype}]")
          fenestrationsurface.setString(2,glztype)
        end
        ###############################################################
      else
        if fenestrationsurface.getString(0).to_s.eql?(choice) || choice.eql?($allchoices)
          no_found = false
          if applicable  #skip the modeling procedure if the model is not supported
            runner.registerInfo("Replacing window on #{fenestrationsurface.getString(0).to_s}")
            runner.registerInfo("Changing [#{fenestrationsurface.getString(2)}] to [#{glztype}]")
            fenestrationsurface.setString(2,glztype)
          
            #fenestrationsurface.setString(6,"ASHRAE_zone78-Frame") #TODO: change this more interactively/automatically
          
          end
        end
      end
    end
        
    ####################################################################################
    #find the thermochromic object and replace switching temperature based on input
    ####################################################################################
    if pce_scenario==true 
      applicable = true
      tcglazings = workspace.getObjectsByType("WindowMaterial:GlazingGroup:Thermochromic".to_IddObjectType)
      tcglazings.each do |tcglazing|
        if tcglazing.getString(0).to_s.eql?("TCGlazing")
          no_found = false
          runner.registerInfo("Matching the pre-defined thermochromic object name =  #{tcglazing.getString(0)}")
          if applicable  #skip the modeling procedure if the model is not supported
            runner.registerInfo("Changing thermochromic switching temperature to #{t_switching}C")
            tcglazing.setString(1,(t_switching-0.5).to_s)
            tcglazing.setString(3,(t_switching).to_s)
                      
          end
        end
      end
    end
        
    ####################################################################################
    #give an error for the name if no surface is changed
    ####################################################################################
    if no_found
      runner.registerError("Measure #{name} cannot find #{choice}. Exiting......")
      return false
    elsif applicable
      # report final condition of workspace
      runner.registerFinalCondition("Imposed fenestration construction name change on #{choice}.")
    else
      runner.registerAsNotApplicable("#{name} is not running for #{choice} because of inapplicability. Skipping......")
    end
    
    # report final condition
    runner.registerFinalCondition("The final IDF file had #{workspace.objects.size} objects.")

    return true

  end

end

#this allows the measure to be use by the application
AInjectWindowSpecificIDFObjects.new.registerWithApplication

