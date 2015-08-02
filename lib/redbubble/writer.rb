module Redbubble
  class Writer
    def initialize
    end

    def write(content:, path:)
      Dir.mkdir(path) unless Dir.exist?(path)
      
      filename = File.join(path, "index.html")
      File.open(filename, 'w') { |f| f.write(content) }
    end

  end
end
