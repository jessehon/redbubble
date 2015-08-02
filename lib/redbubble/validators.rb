require 'redbubble/exceptions'

module Redbubble
  module Validators
    class Validator
      def initialize(label:, field:, type:)
        @label = label
        @field = field
        @type = type
      end

      def valid?
        raise Exceptions::ValidationError, "#{@label} is not type" unless @field.is_a? @type
        return true
      end
    end

    class StringValidator < Validator
      def initialize(label:, field:, min_length: 0, max_length: nil)
        super(label: label, field: field, type: String)
        @min_length = min_length
        @max_length = max_length
      end

      def valid?
        super()
        raise Exceptions::ValidationError, "#{@label} is shorter than #{@min_length} char(s)" if @field.length<@min_length
        unless @max_length.nil?
          raise Exceptions::ValidationError, "#{@label} is longer than #{@max_length} char(s)" if @field.length>@min_length
        end
        return true
      end
    end

    class IntegerValidator < Validator
      def initialize(label:, field:, min_value: nil, max_value: nil)
        super(label: label, field: field, type: Integer)
        @min_value = min_value
        @max_value = max_value
      end

      def valid?
        super()
        unless @max_value.nil?
          raise Exceptions::ValidationError, "#{@label} is smaller than #{@min_value}" if @field<@min_value
        end
        unless @max_value.nil?
          raise Exceptions::ValidationError, "#{@label} is larger than #{@max_value}" if @field>@max_value
        end
        return true
      end
    end
  end
end
