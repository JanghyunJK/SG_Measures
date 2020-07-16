# *******************************************************************************
# OpenStudio(R), Copyright (c) 2008-2018, Alliance for Sustainable Energy, LLC.
# All rights reserved.
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# (1) Redistributions of source code must retain the above copyright notice,
# this list of conditions and the following disclaimer.
#
# (2) Redistributions in binary form must reproduce the above copyright notice,
# this list of conditions and the following disclaimer in the documentation
# and/or other materials provided with the distribution.
#
# (3) Neither the name of the copyright holder nor the names of any contributors
# may be used to endorse or promote products derived from this software without
# specific prior written permission from the respective party.
#
# (4) Other than as required in clauses (1) and (2), distributions in any form
# of modifications or other derivative works may not use the "OpenStudio"
# trademark, "OS", "os", or any other confusingly similar designation without
# specific prior written permission from Alliance for Sustainable Energy, LLC.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDER(S) AND ANY CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
# THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER(S), ANY CONTRIBUTORS, THE
# UNITED STATES GOVERNMENT, OR THE UNITED STATES DEPARTMENT OF ENERGY, NOR ANY OF
# THEIR EMPLOYEES, BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
# OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
# STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
# *******************************************************************************

require 'openstudio'
require 'openstudio/ruleset/ShowRunnerOutput'
require 'minitest/autorun'

require_relative '../measure.rb'

require 'fileutils'

class EnduseTimeseriesCSVExport_Test < MiniTest::Unit::TestCase

  # class level variable
  @@co = OpenStudio::Runmanager::ConfigOptions.new(true) if defined?(OpenStudio::Runmanager::ConfigOptions)
  
  def epw_path
    # set weather data location
    epw = OpenStudio::Path.new(File.dirname(__FILE__)) / OpenStudio::Path.new('USA_TX_Houston-Bush.Intercontinental.AP.722430_TMY3.epw')

    return epw.to_s
  end

  def run_dir(test_name)
    # always generate test output in specially named 'output' directory so result files are not made part of the measure
    return "#{File.dirname(__FILE__)}/output/#{test_name}"
  end
  
  def model_out_path(test_name)
    return "#{run_dir(test_name)}/test_model.osm"
  end
  
  def sql_path(test_name)
    return "#{run_dir(test_name)}/ModelToIdf/EnergyPlusPreProcess-0/EnergyPlus-0/eplusout.sql"
  end
  
  def report_path(test_name)
    return "#{run_dir(test_name)}/report.html"
  end

  #load a model into OS & version translates, exiting and erroring if a problem is found
  def safe_load_model(model_path_string)  
    model_path = OpenStudio::Path.new(model_path_string)
    if OpenStudio::exists(model_path)
      versionTranslator = OpenStudio::OSVersion::VersionTranslator.new 
      model = versionTranslator.loadModel(model_path)
      if model.empty?
        puts "Version translation failed for #{model_path_string}"
        exit
      else
        model = model.get
      end
    else
      puts "#{model_path_string} couldn't be found"
      exit
    end
    return model
  end 
  
  # create test files if they do not exist when the test first runs 
  def setup_test(test_name, idf_output_requests)
  
    @@co.findTools(false, true, false, true)
    
    model_in_path = "#{File.dirname(__FILE__)}/#{test_name}.osm"
    
    if !File.exist?(run_dir(test_name))
      FileUtils.mkdir_p(run_dir(test_name))
    end
    assert(File.exist?(run_dir(test_name)))
    
    if File.exist?(report_path(test_name))
      FileUtils.rm(report_path(test_name))
    end

    assert(File.exist?(model_in_path))
    
    if File.exist?(model_out_path(test_name))
      FileUtils.rm(model_out_path(test_name))
    end

    # convert output requests to OSM for testing, OS App and PAT will add these to the E+ Idf 
    workspace = OpenStudio::Workspace.new("Draft".to_StrictnessLevel, "EnergyPlus".to_IddFileType)
    workspace.addObjects(idf_output_requests)
    rt = OpenStudio::EnergyPlus::ReverseTranslator.new
    request_model = rt.translateWorkspace(workspace)
    model = safe_load_model(model_in_path)
    model.addObjects(request_model.objects)
    model.save(model_out_path(test_name), true)

    if !File.exist?(sql_path(test_name))
      puts "Running EnergyPlus"

      wf = OpenStudio::Runmanager::Workflow.new("modeltoidf->energypluspreprocess->energyplus")
      wf.add(@@co.getTools())
      job = wf.create(OpenStudio::Path.new(run_dir(test_name)), OpenStudio::Path.new(model_out_path(test_name)), OpenStudio::Path.new(epw_path))

      rm = OpenStudio::Runmanager::RunManager.new
      rm.enqueue(job, true)
      rm.waitForFinished
    end
  end

  def test_model
  
    test_name = "test_model"

    # create an instance of the measure
    measure = EnduseTimeseriesCSVExport.new

    # create an instance of a runner
    runner = OpenStudio::Ruleset::OSRunner.new
    runner.setLastOpenStudioModelPath(OpenStudio::Path.new("#{File.dirname(__FILE__)}/#{test_name}.osm"))
    
    # Load the test model
    translator = OpenStudio::OSVersion::VersionTranslator.new
    path = OpenStudio::Path.new(File.dirname(__FILE__) + "/#{test_name}.osm")
    model = translator.loadModel(path)
    assert((not model.empty?))
    model = model.get    
    
    # Get arguments and test that they are what we are expecting
    arguments = measure.arguments()
    argument_map = OpenStudio::Ruleset::OSArgumentMap.new 

    # Set argument values
    arg_values = {
    "reporting_frequency" => "Hourly",
    }
   
    i = 0
    arg_values.each do |name, val|
      arg = arguments[i].clone
      assert(arg.setValue(val), "Could not set #{name} to #{val}")
      argument_map[name] = arg
      i += 1
    end
    
    # get the energyplus output requests, this will be done automatically by OS App and PAT
    idf_output_requests = measure.energyPlusOutputRequests(runner, argument_map)
    assert(idf_output_requests.size > 0)

    # mimic the process of running this measure in OS App or PAT
    setup_test(test_name, idf_output_requests)
    
    assert(File.exist?(model_out_path(test_name)))
    assert(File.exist?(sql_path(test_name)))
    assert(File.exist?(epw_path))

    # set up runner, this will happen automatically when measure is run in PAT or OpenStudio
    runner.setLastOpenStudioModelPath(OpenStudio::Path.new(model_out_path(test_name)))
    runner.setLastEpwFilePath(epw_path)
    runner.setLastEnergyPlusSqlFilePath(OpenStudio::Path.new(sql_path(test_name)))

    # delete the output if it exists
    if File.exist?(report_path(test_name))
      FileUtils.rm(report_path(test_name))
    end
    assert(!File.exist?(report_path(test_name)))
    
    # temporarily change directory to the run directory and run the measure
    start_dir = Dir.pwd
    begin
      Dir.chdir(run_dir(test_name))

      # run the measure
      measure.run(runner, argument_map)
      result = runner.result
      show_output(result)
      assert_equal("Success", result.value.valueName)
    ensure
      Dir.chdir(start_dir)
    end
    
    # make sure the report file exists
    assert(File.exist?(report_path(test_name)))
  end 
  
end
