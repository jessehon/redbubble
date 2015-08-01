require 'redbubble/views/base_view'

module Redbubble
  module Views
    class MakeDetailView < BaseView
      def initialize(template:, resolver:, make:)
        super(template: template, resolver: resolver)
        @make = make
      end

      def item_links
        @make.models.each do |model|
          model_segment = PathSegment.create_for_model(model_name: model.name)
          model_resolver = @resolver.resolver(model_segment)
          result << Link.new(name: model_resolver.title, href: model_resolver.path)
        end
      end

      def thumbnails
        result = []
        @model.works.first(10).each do |work|
          result << Image.new(src: work.url)
        end
      end
    end
  end
end
