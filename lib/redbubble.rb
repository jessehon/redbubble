require 'redbubble/reader'
require 'redbubble/writer'
require 'redbubble/html_generator'
require 'redbubble/path_resolver'
require 'redbubble/exceptions'
require 'redbubble/models/make'

module Redbubble
  DEFAULT_TEMPLATE_FILE = File.join(File.dirname(__FILE__), "redbubble", "templates", "output.html.erb")
  DEFAULT_OUTPUT_PATH = File.join(File.dirname(__FILE__), "..", "output")

  def self.run(input_file:, output_path: DEFAULT_OUTPUT_PATH, template_file: DEFAULT_TEMPLATE_FILE)
    raise Exceptions::FileNotFoundError, "Input file #{input_file} could not be found" unless File.exist?(input_file)
    raise Exceptions::FileNotFoundError, "Template file #{template_file} could not be found" unless File.exist?(template_file)
    raise Exceptions::DirectoryNotFoundError, "Directory #{output_path} could not be found" unless Dir.exist?(output_path)

    works = Reader.new(input_file: input_file).read
    makes = Models::Make.create_from_works(works: works)

    resolver = PathResolver.new(root_path: output_path)
    writer = Writer.new()
    HtmlGenerator.new(
        makes: makes,
        template_file: template_file,
        resolver: resolver,
        writer: writer
      ).generate
  end

end
