require 'redbubble/views/base_view'

module Redbubble
  module Views
    class ModelDetailView < BaseView
      def initialize(template:, resolver:, model:)
        super(template: template, resolver: resolver)
        @model = model
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
