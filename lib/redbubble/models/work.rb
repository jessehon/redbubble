require 'redbubble/models/base_model'

module Redbubble
  module Models
    class Work < BaseModel
      attr_reader :id, :make_name, :model_name, :thumbnail_url;

      def initialize(id:, model_name:, make_name:, thumbnail_url:)
        @id = id
        @model_name = model_name
        @make_name = make_name
        @thumbnail_url = thumbnail_url
      end

      def to_s
        @id
      end

      def self.create_from_xml_node(node)
        Work.new(
          id: node.css('id').text,
          model_name: node.css('exif > model').text,
          make_name: node.css('exif > make').text,
          thumbnail_url: node.css('urls > url[type=small]').text
        )
      end
    end
  end
end
