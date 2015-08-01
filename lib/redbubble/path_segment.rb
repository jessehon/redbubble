module Redbubble
  class PathSegment
    attr_reader :title, :path;

    def initialize(title:, path)
      @title = title
      @path = (defined?(path))? path : slugify(title)
    end

    def create_for_index
      PathSegment.new(title: "Redbubble")
    end

    def create_for_make(make_name:)
      PathSegment.new(title: make_name)
    end

    def create_for_model(model_name:)
      PathSegment.new(title: model_name)
    end

    def slugify(s)
      s.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
    end
  end
end
