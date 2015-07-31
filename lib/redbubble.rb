require 'redbubble/reader'
module Redbubble
  def self.run(input_file:, template_file:)
    works = Reader.new(input_file).read

  end
end
