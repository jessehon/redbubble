module Redbubble
  class PathSegment
    attr_reader :title, :path;

    def initialize(title:, path: nil)
      @title = title
      @path = if path.nil? then slugify(title) else path end
    end

    def to_s
      @path
    end

    def self.create_for_index
      PathSegment.new(title: "Redbubble", path: "")
    end

    def self.create_for_make(make_name:)
      PathSegment.new(title: make_name)
    end

    def self.create_for_model(model_name:)
      PathSegment.new(title: model_name)
    end

    def slugify(s)
      s.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
    end
  end
end
