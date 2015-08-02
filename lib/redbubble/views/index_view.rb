require 'redbubble/views/base_view'
require 'redbubble/views/components/image'
require 'redbubble/views/components/link'

module Redbubble
  module Views
    class IndexView < BaseView
      def initialize(template:, resolver:, makes:)
        super(template: template, resolver: resolver)
        @makes = makes
      end

      def item_links
        @makes.map do |make|
          make_segment = PathSegment.create_for_make(make_name: make.name)
          make_resolver = @resolver.resolver(make_segment)
          Views::Components::Link.new(name: make_resolver.title, href: File.join(make_resolver.path, "index.html"))
        end
      end

      def thumbnails
        works = (@makes.map { |make| make.works }).flatten
        works.first(10).map do |work|
          Views::Components::Image.new(src: work.thumbnail_url)
        end
      end
    end
  end
end
