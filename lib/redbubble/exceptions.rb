module Redbubble
  module Exceptions
    class RedbubbleError < StandardError; end

    class ValidationError < RedbubbleError; end
  end
end
