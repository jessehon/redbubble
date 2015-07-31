module Redbubble
  class PathResolver
    def initialize(root)
      @root = root
    end

    def relative_make_detail(make_name:)
      slugify(make_name)
    end

    def relative_model_detail(model_name:)
      slugify(model_name)
    end

    def absolute_index
      @root
    end

    def absolute_make_detail(make_name:)
      File.join(absolute_index, relative_make_detail(make_name))
    end

    def absolute_model_detail(make_name:, model_name:)
      File.join(absolute_make_detail(make_name), relative_model_detail(model_name))
    end

    def slugify(s)
      s.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
    end
  end
end
