require 'redbubble/views/base_view'

module Redbubble
  module Views
    class IndexView < BaseView
      def initialize(template:, resolver:, makes:)
        super(template: template, resolver: resolver)
        @makes = makes
      end

      def item_links
        @makes.each do |make|
          make_segment = PathSegment.create_for_make(make_name: make.name)
          make_resolver = @resolver.resolver(make_segment)
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
