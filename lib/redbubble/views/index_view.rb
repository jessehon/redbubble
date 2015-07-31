require 'redbubble/views/base_view'

module Redbubble
  module Views
    class IndexView < BaseView
      VIEW_TITLE = "Redbubble"

      def initialize(template:, path_resolver:, makes:)
        super(template: template, path_resolver: path_resolver)
        @makes = makes
      end

      def title
        VIEW_TITLE
      end

      def path
        @path_resolver.absolute_index
      end

      def item_links
        @makes.each do |make|
          href = @path_resolver.absolute_make_detail(make_name: @make.name)
          result << Link.new(name: make.name, href: href)
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
