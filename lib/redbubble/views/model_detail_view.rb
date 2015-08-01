require 'redbubble/views/base_view'

module Redbubble
  module Views
    class ModelDetailView < BaseView
      def initialize(template:, path_resolver:, model:)
        super(template: template, path_resolver: path_resolver)
        @model = model
      end

      def title
        "%s - %s" % (@model.make_name, @model.name)
      end

      def path
        @path_resolver.absolute_model_detail(make_name: @model.make_name, model_name: @model.name)
      end

      def back_links
        [ Link.new(name: 'Back to home', href: @path_resolver.absolute_index),
          Link.new(name: 'Back to make', href: @path_resolver.absolute_make_detail(make_name: @model.make_name)),
        ]
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
