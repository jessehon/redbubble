require 'nokogiri'
require 'redbubble/models/work'

module Redbubble
  class Reader
    def initialize(input_file:)
      @input_file = input_file
    end

    def read
      doc = parse_xml
      works = []
      works = doc.css("works > work").collect do |node|
        begin
          Redbubble::Models::Work.create_from_xml_node(node)
        rescue Redbubble::Models::WorkMissingModelOrMakeError => e
          puts "Skipping work with after exception #{e}"
        end
      end
      works.compact
    end

    def parse_xml
      f = File.open(@input_file)
      doc = Nokogiri::XML(f)
      f.close

      doc
    end
  end
end
