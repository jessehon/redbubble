module Redbubble
  module Views
    class BaseView
      def initialize(template:, resolver:)
        @template = template
        @resolver = resolver
      end

      def title
        @resolver.title
      end

      def back_links
        @resolver.breadcrumbs.map do |r|
          Link.new(name: r.title, href: r.path)
        end
      end

      def thumbnails
        []
      end

      def item_links
        []
      end

    end
  end
end
