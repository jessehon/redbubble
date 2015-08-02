require 'redbubble/models/base_model'
require 'redbubble/validators'
require 'redbubble/exceptions'

module Redbubble
  module Models
    class WorkMissingModelOrMakeError < Exceptions::ValidationError; end

    class Work < BaseModel
      attr_reader :id, :make_name, :model_name, :thumbnail_url;

      def initialize(id:, model_name:, make_name:, thumbnail_url:)
        @id = id
        @model_name = model_name
        @make_name = make_name
        @thumbnail_url = thumbnail_url
        super()
      end

      def valid?
        super()
        validators = [
            Validators::IntegerValidator.new(field: @id, label: "id", min_value: 0),
            Validators::StringValidator.new(field: @make_name, label: "Make name", min_length: 1),
            Validators::StringValidator.new(field: @model_name, label: "Model name", min_length: 1),
            Validators::StringValidator.new(field: @thumbnail_url, label: "Thumbnail url", min_length: 1)
          ].each {|v| v.valid?}
        return true
      end

      def to_s
        @id
      end

      def self.create_from_xml_node(node)
        # allow reader to skip if both make and model does not exist
        attributes = {
          id: node.css('id').text.to_i,
          model_name: node.css('exif > model').text,
          make_name: node.css('exif > make').text,
          thumbnail_url: node.css('urls > url[type=small]').text
        }

        if attributes[:model_name].empty? || attributes[:make_name].empty?
          raise WorkMissingModelOrMakeError, "Work #{attributes[:id]} is missing either model and make"
        end

        Work.new(attributes)
      end
    end
  end
end
