require 'redbubble/views/base_view'

module Redbubble
  module Views
    class MakeDetailView < BaseView
      def initialize(template:, path_resolver:, make:)
        super(template: template, path_resolver: path_resolver)
        @make = make
      end

      def title
        @make.name
      end

      def path
        @path_resolver.absolute_make_detail(make_name: @make.name)
      end

      def back_links
        [Link.new(name: 'Back to home', href: @path_resolver.absolute_index)]
      end

      def item_links
        @make.models.each do |model|
          href = @path_resolver.absolute_model_detail(make_name: @make.name, model_name: @model.name)
          result << Link.new(name: model.name, href: href)
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
