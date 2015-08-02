module Redbubble
  class Link
    attr_reader :name, :href;

    def initialize(name:, href:)
      @name = name
      @href = href
    end
  end
end
