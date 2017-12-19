module JSON
  module SchemaBuilder
    class Schema
      attr_accessor :data
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
          if current_key == "anyOf"
            _deep_merge_any_of(Array(this_value), Array(other_value))
          elsif this_value.is_a?(::Array) && other_value.is_a?(::Array)
            this_value + other_value
          else
            other_value
          end
        end
      end

      def _deep_merge_any_of(this, other)
        object = self.class.new
        combined = []

        (this + other).each do |item|
          if item[:type].to_sym == :object
            object.data = object._deep_merge(object.data, item)
          else
            combined << item
          end
        end

        combined << object.data unless object.data.empty?
        combined.uniq
      end
    end
  end
end
