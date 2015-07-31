require 'nokogiri'
require 'redbubble/models/work'

module Redbubble
  class Reader
    def initialize(input_file)
      @input_file = input_file
    end

    def read
      doc = parse_xml
      works = []
      doc.css("works > work").each do |node|
        works << Redbubble::Models::Work.create_from_xml_node(node)
      end
    end

    def parse_xml
      f = File.open(@input_file)
      doc = Nokogiri::XML(f)
      f.close

      doc
    end
  end
end
