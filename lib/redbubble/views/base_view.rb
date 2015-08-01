module Redbubble
  module Views
    class BaseView
      def initialize(template:, path_resolver:)
        @template = template
        @path_resolver = path_resolver
      end

      def title
        @path_resolver.title
      end

      def path
        @path_resolver.path
      end

      def back_links
        @path_resolver.breadcrumbs.map do |r|
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
