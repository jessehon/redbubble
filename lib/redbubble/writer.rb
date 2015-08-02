require 'fileutils'

module Redbubble
  class Writer
    def initialize
    end

    def write(content:, path:, filename: "index.html")
      FileUtils.mkdir_p(path) unless Dir.exist?(path)

      file_path = File.join(path, filename)
      File.open(file_path, 'w') { |f| f.write(content) }
      file_path
    end

  end
end
