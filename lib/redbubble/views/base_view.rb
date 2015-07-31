module Redbubble
  module Views
    class BaseView
      def initialize(template:, path_resolver:)
        @template = template
        @path_resolver = path_resolver
      end

      def title
        raise NotImplementedError
      end

      def back_links
        []
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
