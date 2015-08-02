module Redbubble
  class Image
    attr_reader :src;

    def initialize(src:)
      @src = src
    end
  end
end
