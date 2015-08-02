module Redbubble
  module Exceptions
    class RedbubbleError < StandardError; end

    class ValidationError < RedbubbleError; end
    class FileNotFoundError < RedbubbleError; end
    class DirectoryNotFoundError < RedbubbleError; end
  end
end
