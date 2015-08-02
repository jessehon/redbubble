module Redbubble
  module Models
    class BaseModel
      def initialize
        valid?
      end

      def valid?
        return true
      end
    end
  end
end
