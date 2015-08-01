module Redbubble
  class PathResolver
    attr_reader :segmants;

    def initialize(segmants = [], root_path = "")
      @root_path = root_path
      @segmants = segmants
    end

    def resolver(segmant)
      PathResolver.new(@segmants.concat(segmant))
    end

    def title
      title = @segmants.fetch(-1).title
    end

    def path
      paths = @segmants.map {|s| s.path}
      File.join(@root_path, paths)
    end

    def up(steps)
      return nil if @segmants.length == 1
      PathResolver.new(@segmants[0...-steps])
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
