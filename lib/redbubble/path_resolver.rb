module Redbubble
  class PathResolver
    attr_reader :segments;

    def initialize(segments = [], root_path = "")
      @root_path = root_path
      @segments = segments
    end

    def resolver(segment)
      PathResolver.new(@segments.concat(segment))
    end

    def title
      title = @segments.fetch(-1).title
    end

    def path
      paths = @segments.map {|s| s.path}
      File.join(@root_path, paths)
    end

    def up(steps)
      return nil if @segments.length == 1
      PathResolver.new(@segments[0...-steps])
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
