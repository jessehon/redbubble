require 'redbubble/views/base_view'
require 'redbubble/views/components/image'
require 'redbubble/views/components/link'

module Redbubble
  module Views
    class MakeDetailView < BaseView
      def initialize(template:, resolver:, make:)
        super(template: template, resolver: resolver)
        @make = make
      end

      def item_links
        @make.models.map do |model|
          model_segment = PathSegment.create_for_model(model_name: model.name)
          model_resolver = @resolver.resolver(model_segment)
          Components::Link.new(name: model_resolver.title, href: model_resolver.path)
        end
      end

      def thumbnails
        @make.works.first(10).map do |work|
          Views::Components::Image.new(src: work.thumbnail_url)
        end
      end
    end
  end
end
