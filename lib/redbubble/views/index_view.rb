require 'redbubble/views/base_view'

module Redbubble
  module Views
    class IndexView < BaseView
      def initialize(template:, path_resolver:, makes:)
        super(template: template, path_resolver: path_resolver)
        @makes = makes
      end

      def item_links
        @makes.each do |make|
          make_segmant = PathSegmant.create_for_make(make_name: make.name)
          make_resolver = @path_resolver.resolver(make_segmant)
          result << Link.new(name: make_resolver.title, href: make_resolver.path)
        end
      end

      def thumbnails
        result = []
        #TODO fix first 10
        @makes.each do |make|
          make.works.first(10).each do |work|
            result << Image.new(src: work.url)
          end
        end
      end
    end
  end
end
