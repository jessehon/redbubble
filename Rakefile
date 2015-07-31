# require "bundler/gem_tasks"
require "rspec/core/rake_task"
require 'optparse'

RSpec::Core::RakeTask.new(:spec)
task :default => [:run]

desc "Specify input works file and output template"
task "run" do
  $LOAD_PATH.unshift(File.dirname(__FILE__), "lib")
  require 'redbubble'

  input_file = ENV['input']
  unless ENV.has_key?('input')
    raise ArgumentError, "missing required argument 'input'"
  end

  template_file = ENV['template']
  unless ENV.has_key?('template')
    raise ArgumentError, "missing required argument 'template'"
  end

  Redbubble.run(input_file: input_file, template_file: template_file)
end
