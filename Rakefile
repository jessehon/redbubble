# require "bundler/gem_tasks"
require "rspec/core/rake_task"
require 'optparse'

task :default => [:run]

desc <<-eos
Processes input file containing Redbubble camera 'work' XML data and generates formatted HTML files grouped by Make and Model
Usage: rake run input=FILENAME [options...]
Options are ...
    template=FILENAME      ERB template file to be used in place of default
    output_dir=PATH        Output directory that will serve as base directory for generated files, defaults to "../output"
eos
task "run" do
  $LOAD_PATH.unshift(File.dirname(__FILE__), "lib")
  require 'redbubble'

  kwargs = {}

  unless ENV.has_key?('input')
    raise ArgumentError, "missing required argument 'input'"
  end
  kwargs[:input_file] = ENV['input']

  if ENV.has_key?('template')
    kwargs[:template_file] = ENV['template']
  end

  if ENV.has_key?('output_dir')
    kwargs[:output_path] = ENV['output_dir']
  end

  Redbubble.run(kwargs)
end

desc <<-eos
Run RSpec code tests
Usage: rake spec
eos
RSpec::Core::RakeTask.new(:spec)
