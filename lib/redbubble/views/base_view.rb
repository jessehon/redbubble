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
        breadcrumbs = @resolver.breadcrumbs
        breadcrumbs.pop
        breadcrumbs.map do |r|
          Views::Components::Link.new(name: r.title, href: r.path)
        end
      end

      def thumbnails
        []
      end

      def item_links
        []
      end

      def render
        title = self.title
        thumbnails = self.thumbnails
        back_links = self.back_links
        item_links = self.item_links
        @template.result(binding)
      end

    end
  end
end
