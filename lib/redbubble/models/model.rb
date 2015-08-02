require 'redbubble/models/base_model'

module Redbubble
  module Models
    class Model < BaseModel
      attr_reader :name, :works, :make_name;

      def initialize(name:, make_name:, works:)
        @name = name
        @make_name = make_name
        @works = works
        super()
      end

      def valid?
        super()
        validators = [
            Validators::StringValidator.new(field: @name, label: "Model name", min_length: 1),
            Validators::StringValidator.new(field: @make_name, label: "Make name", min_length: 1),
            Validators::Validator.new(field: @works, label: "Works", type: Array)
          ].each {|v| v.valid?}
        return true
      end

      def to_s
        @name
      end

      def self.create_from_make_works(make_name:, make_works:)
        models = {}

        works_by_model = make_works.group_by(&:model_name)
        works_by_model.each do |model_name, model_works|
          models[model_name] ||= Model.new(name: model_name, make_name: make_name, works: model_works)
        end
      end

      def self.create_from_makes(makes:)
        models = {}

        makes.each do |make_name, make|
          models.merge!(Model.create_from_make_works(make_name: make_name, make_works: make.works))
        end
      end
    end
  end
end
