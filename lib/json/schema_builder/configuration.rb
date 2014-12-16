require 'ostruct'

module JSON
  module SchemaBuilder
    module Configuration
      def options
        return @options if @options
        defaults = JSON::SchemaBuilder.default_options
        @options = OpenStruct.new defaults.to_h
      end

      def options=(config)
        @options = OpenStruct.new config.to_h
      end

      def configure
        @options = nil
        yield(options) if block_given?
      end
    end
  end
end
