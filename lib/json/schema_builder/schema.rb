module JSON
  module SchemaBuilder
    class Schema
      attr_reader :data
      delegate :[], :[]=, :to_h, :as_json, to: :data

      def initialize(hash = {})
        @data = hash.with_indifferent_access
      end

      def merge(schema)
        self.class.new _deep_merge(data, schema.data)
      end

      def merge!(schema)
        @data = _deep_merge(data, schema.data)
        self
      end

      def _deep_merge(this, other)
        this.deep_merge(other) do |current_key, this_value, other_value|
          if this_value.is_a?(::Array) && other_value.is_a?(::Array)
            this_value + other_value
          else
            other_value
          end
        end
      end
    end
  end
end
