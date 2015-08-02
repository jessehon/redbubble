require 'redbubble/models/base_model'
require 'redbubble/models/model'

module Redbubble
  module Models
    class Make < BaseModel
      attr_reader :name, :models;

      def initialize(name:, models:)
        @name = name
        @models = models
        super()
      end

      def valid?
        super()
        validators = [
            Validators::StringValidator.new(field: @name, label: "Model name", min_length: 1),
            Validators::Validator.new(field: @models, label: "Models", type: Array)
          ].each {|v| v.valid?}
        return true
      end

      def to_s
        @name
      end

      def works
        (models.map { |m| m.works }).flatten
      end

      def self.create_from_works(works:)
        makes = {}
        works_by_make = works.group_by(&:make_name)
        works_by_make.each do |make_name, make_works|
          makes[make_name] ||= Make.new(
            name: make_name,
            models: Model.create_from_make_works(make_name: make_name, make_works: make_works)
          )
        end
      end
    end

  end
end
