#!/usr/bin/env ruby
# CLI tool to allow for downloading and parsing results for AFDD analyses
# Written by Henry R Horsey III (henry.horsey@nrel.gov)
# Created May 23rd, 2018
# Last updated on May 23rd, 2018
# Copywrite the Alliance for Sustainable Energy LLC
# License: BSD3+1


require 'optparse'
require 'openstudio-analysis'
require 'fileutils'
require 'zip'


# Unzip the sensors.csv file to the destination directory using Rubyzip gem
#
# @param archive [:string] archive path for extraction
# @param dest [:string] path for archived file to be extracted to
# @param dpname [:string] data point uuid to persist the file with
def retrieve_sensor_data(archive, dest, dpname)
  # Adapted from examples at...
  # https://github.com/rubyzip/rubyzip
  # http://seenuvasan.wordpress.com/2010/09/21/unzip-files-using-ruby/
  begin
    Zip::File.open(archive) do |zf|
      zf.each do |f|
        if f.name =~ /.*sensors.csv/
          f_path = File.join(dest, dpname + '_sensors.csv')
          FileUtils.mkdir_p(File.dirname(f_path))
          zf.extract(f, f_path) unless File.exist?(f_path) # No overwrite
        end
      end
    end
  rescue => e
    puts "Error in zip method for #{dpname}: #{e.message}"
  end
end


# Download any datapoint that does not already have a zip in the localResults directory
#
# @param local_result_dir [::String] path to the localResults directory
# @param dest [::String] path to the folder to write sensor files to
# @param server_api [::OpenStudio::Analysis::ServerApi] API to serve zips
# @param interval [::Fixnum] Percent interval to report progress to STDOUT
# @return [logical] Indicates if any errors were caught
def retrieve_dp_data(local_results_dir, dest, server_api, interval=10, analysis_id=nil)
  # Verify localResults directory
  unless File.basename(local_results_dir) == 'localResults'
    fail "ERROR: input #{local_results_dir} does not point to localResults"
  end

  # Verify dest directory
  unless File.exist?(dest)
    fail "ERROR: dest #{dest} does not exist"
  end

  # Ensure there are datapoints to download
  dps = server_api.get_datapoint_status analysis_id
  dps_error_count = 0
  if dps.nil? || dps.empty?
    fail 'ERROR: No datapoints found. Analysis completed with no datapoints'
  end

  # Only download datapoints which do not already exist
  #exclusion_list = Dir.entries local_results_dir
  exclusion_list = []
  report_at = interval
  timestep = Time.now
  dps.each_with_index do |dp, count|
  	# puts "  processing #{dp}"
    if exclusion_list.include? dp[:_id]
      if File.exist?(File.join(local_results_dir, dp[:_id], 'data_point.zip'))
        f = File.join(local_results_dir, dp[:_id], 'data_point.zip')
      end
    else
      # Download datapoint; in case of failure document and continue
      ok, f = server_api.download_datapoint dp[:_id], local_results_dir
      unless ok
        puts "ERROR: Failed to download data point #{dp[:_id]}"
        dps_error_count += 1
      end
    end
    retrieve_sensor_data f, dest, dp[:_id]
	# retrieve_sensor_data(f, dest, dp[:_id])

    if File.exist?(File.join(local_results_dir, 'data_point.zip'))
      File.delete(File.join(local_results_dir, 'data_point.zip'))
    end

    # Report out progress
    if count.to_f * 100 / dps.length >= report_at
      puts "INFO: Completed #{report_at}%; #{(Time.now - timestep).round}s"
      report_at += interval
      timestep = Time.now
    end
  end

  dps_error_count
end


# Initialize optionsParser ARGV hash
options = {}

# Define allowed ARGV input
# -s --server_dns [string]
# -p --project_dir [string]
optparse = OptionParser.new do |opts|
  opts.banner = 'Usage:    complete_localResults [-s] <server_dns> [-p] <project_dir> -a <analysis_id> -d <destination_dir> [-h]'

  options[:project_dir] = nil
  opts.on('-p', '--project_dir <dir>', 'specified project DIRECTORY') do |dir|
    options[:project_dir] = dir
  end

  options[:dns] = nil
  opts.on('-s', '--server_dns <DNS>', 'specified server DNS') do |dns|
    options[:dns] = dns
  end

  options[:a_id] = nil
  opts.on('-a', '--analysis_id <ID>', 'analysis UUID') do |id|
    options[:a_id] = id
  end

  options[:dest_dir] = nil
  opts.on('-d', '--destination_dir <DIR>', 'destination DIRECTORY') do |dest_dir|
    options[:dest_dir] = dest_dir
  end
  
  opts.on_tail('-h', '--help', 'display help') do
    puts opts
    exit
  end
end

# Execute ARGV parsing into options hash holding symbolized key values
optparse.parse!

# Check inputs for basic compliance criteria
unless Dir.exists?(options[:project_dir])
  fail "ERROR: Could not find #{options[:project_dir]}"
end
unless Dir.entries(options[:project_dir]).include? 'pat.json'
  fail "ERROR: pat.json file not found in #{options[:project_dir]}"
end

# Create the localResults directory should it not exist
local_results_dir = File.join(options[:project_dir], 'localResults')
unless Dir.exists? local_results_dir
  Dir.mkdir local_results_dir
end

# Create the destination directory should it not exist
dest_dir = File.absolute_path(options[:dest_dir])
unless Dir.exists? dest_dir
  Dir.mkdir dest_dir
end

# Get OpenStudioServerApi object and ensure the instance is running
server_api = OpenStudio::Analysis::ServerApi.new(hostname: options[:dns])
unless server_api.machine_status
  fail "ERROR: Server #{server_api.hostname} not responding to ServerApi"
end

# Retrieve the datapoints and indicate success
Zip.warn_invalid_date = false
failed_dps = retrieve_dp_data(local_results_dir, dest_dir, server_api, 10, options[:a_id])
fail "ERROR: Retrieval failed #{failed_dps} times" if failed_dps != 0
puts 'SUCCESS: Exiting'
exit 0
