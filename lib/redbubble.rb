require 'redbubble/reader'
require 'redbubble/writer'
require 'redbubble/html_generator'
require 'redbubble/models/make'

module Redbubble
  def self.run(input_file:, template_file:)
    works = Reader.new(input_file: input_file).read
    makes = Redbubble::Models::Make.create_from_works(works: works)

    resolver = PathResolver.new()
    writer = Writer.new()
    HtmlGenerator(
      makes: makes,
      template_file: template_file,
      resolver: resolver,
      writer: writer
    ).generate
  end

end
