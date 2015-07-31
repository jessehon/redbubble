require 'redbubble/models/base_model'
require 'redbubble/models/model'

module Redbubble
  module Models
    class Make < BaseModel
      attr_reader :name, :models;

      def initialize(name:, models:)
        @name = name
        @models = models
      end

      def to_s
        @name
      end

      def works
        result = {}
        models.each do |model_works|
          result.concat!(model_works)
        end
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
