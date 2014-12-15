require 'ostruct'

module JSON
  module SchemaBuilder
    class Schema < OpenStruct
      def merge(schema)
        self.class.new to_h.deep_merge schema.to_h
      end

      def merge!(schema)
        @table = to_h.deep_merge schema.to_h
        self
      end
    end
  end
end
