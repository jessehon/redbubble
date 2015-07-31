require 'redbubble/reader'
require 'redbubble/models/make'

module Redbubble
  def self.run(input_file:, template_file:)
    works = Reader.new(input_file: input_file).read
    makes = Redbubble::Models::Make.create_from_works(works: works)


  end
end
