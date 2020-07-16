#see the URL below for information on how to write OpenStudio measures
# http://openstudio.nrel.gov/openstudio-measure-writing-guide

#see the URL below for information on using life cycle cost objects in OpenStudio
# http://openstudio.nrel.gov/openstudio-life-cycle-examples

#see the URL below for access to C++ documentation on model objects (click on "model" in the main window to view model objects)
# https://s3.amazonaws.com/openstudio-sdk-documentation/index.html

$allchoices = 'All fenestration surfaces'

# start the measure
class ChangeWindowConstruction < OpenStudio::Ruleset::WorkspaceUserScript

  # human readable name
  def name
    return 'Change construction name in fenestration surfaces'
  end

  # human readable description
  def description
    return "changing the construction name assigned in FenestrationSurface:Detailed objects to the specified argument string."
  end

  # human readable description of workspace approach
  def modeler_description
    return "this is to use with Inject_IDF measure to assign correct window construction names when glazing materials are imported via Inject_IDF measure."
  end

  # define the arguments that the user will input
  def arguments(workspace)
    args = OpenStudio::Ruleset::OSArgumentVector.new
    
    #make choice arguments for fenestration surface
    fenestrationsurfaces = workspace.getObjectsByType("FenestrationSurface:Detailed".to_IddObjectType)
    chs = OpenStudio::StringVector.new
    fenestrationsurfaces.each do |fenestrationsurface|
      chs << fenestrationsurface.name.to_s
    end
    chs << $allchoices
    choice = OpenStudio::Ruleset::OSArgument::makeChoiceArgument('choice', chs, true)
    choice.setDisplayName("Choice of window.")
    choice.setDefaultValue($allchoices)
    args << choice
    
    #set window construction name
    name_construction = OpenStudio::Ruleset::OSArgument.makeStringArgument('name_construction', false)
    name_construction.setDisplayName('Window construction name that is imported through Inject_IDF measure.')
    name_construction.setDefaultValue("GlzSys_6")  
    args << name_construction

    return args
  end

  # define what happens when the measure is run
  def run(workspace, runner, user_arguments)
    super(workspace, runner, user_arguments)

    # use the built-in error checking
    if !runner.validateUserArguments(arguments(workspace), user_arguments)
      return false
    end
    
    #obtain values
    choice = runner.getStringArgumentValue('choice',user_arguments)
    name_construction = runner.getStringArgumentValue('name_construction',user_arguments)
    
    runner.registerInitialCondition("Imposing fenestration construction name change on #{choice}.")
  
    #find the fenestration surface to change
    no_found = true
    applicable = true
    fenestrationsurfaces = workspace.getObjectsByType("FenestrationSurface:Detailed".to_IddObjectType)
    fenestrationsurfaces.each do |fenestrationsurface|
      if fenestrationsurface.getString(0).to_s.eql?(choice) || choice.eql?($allchoices)
        no_found = false
        if applicable  #skip the modeling procedure if the model is not supported
          runner.registerInfo("Changing [#{fenestrationsurface.getString(2)}] to [#{name_construction}]")
          fenestrationsurface.setString(2,name_construction) 
        end
      end
    end
    
    #give an error for the name if no surface is changed
    if no_found
      runner.registerError("Measure #{name} cannot find #{choice}. Exiting......")
      return false
    elsif applicable
      # report final condition of workspace
      runner.registerFinalCondition("Imposed fenestration construction name change on #{choice}.")
    else
      runner.registerAsNotApplicable("#{name} is not running for #{choice} because of inapplicability. Skipping......")
    end

    return true

  end
  
end

# register the measure to be used by the application
ChangeWindowConstruction.new.registerWithApplication
