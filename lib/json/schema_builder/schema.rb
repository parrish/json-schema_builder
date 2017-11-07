require 'ostruct'

module JSON
  module SchemaBuilder
    class Schema < OpenStruct
      def merge(schema)
        self.class.new to_h.deep_stringify_keys.deep_merge(schema.to_h.deep_stringify_keys)
      end

      def merge!(schema)
        @table = to_h.deep_stringify_keys.deep_merge schema.to_h.deep_stringify_keys
        self
      end
    end
  end
end
