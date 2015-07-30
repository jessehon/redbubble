require 'optparse'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: example.rb [options]"

  opts.on("-i","--input-file FILE", String) do |file|
    options[:input_file] = file
  end
end.parse!

p options
p ARGV
