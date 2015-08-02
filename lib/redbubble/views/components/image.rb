module Redbubble
  module Views
    module Components
      class Image
        attr_reader :src;

        def initialize(src:)
          @src = src
        end
      end
    end
  end
end
