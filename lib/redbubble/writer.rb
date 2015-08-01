module Redbubble
  class Writer
    def initialize(root_path = "")
      @root_path = root_path
    end

    def write(content:, path:)
      filename = File.join(@root_path, path, "index.html")
      File.open(filename, 'w') { |f| f.write(content) }
    end

  end
end
