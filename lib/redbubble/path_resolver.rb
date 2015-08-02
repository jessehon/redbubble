module Redbubble
  class PathResolver
    attr_reader :segments;

    def initialize(segments: [], root_path: "")
      @root_path = root_path
      @segments = segments
    end

    def resolver(segment)
      PathResolver.new(segments: (@segments + [segment]), root_path: @root_path)
    end

    def title
      return "" if @segments.empty?
      @segments.fetch(-1).title
    end

    def path
      paths =[@root_path] + @segments.map {|s| s.path}
      File.join(paths)
    end

    def up(steps)
      return nil if @segments.length <= 1
      PathResolver.new(segments: @segments[0...-steps], root_path: @root_path)
    end

    def breadcrumbs
      result = []
      resolver = self
      while resolver
        result << resolver
        resolver = resolver.up(1)
      end
      result.reverse
    end
  end
end
