require 'redbubble/views/base_view'
require 'redbubble/views/components/image'

module Redbubble
  module Views
    class ModelDetailView < BaseView
      def initialize(template:, resolver:, model:)
        super(template: template, resolver: resolver)
        @model = model
      end

      def thumbnails
        @model.works.first(10).map do |work|
          Views::Components::Image.new(src: work.thumbnail_url)
        end
      end
    end
  end
end
