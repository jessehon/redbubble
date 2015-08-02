# require "bundler/gem_tasks"
require "rspec/core/rake_task"
require 'optparse'

RSpec::Core::RakeTask.new(:spec)
task :default => [:run]

desc "Specify input works file and output template"
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

  Redbubble.run(kwargs)
end
