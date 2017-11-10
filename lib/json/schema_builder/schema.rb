module JSON
  module SchemaBuilder
    class Schema
      attr_reader :data
      delegate :[], :[]=, :to_h, :as_json, to: :data

      def initialize(hash = {})
        @data = hash.with_indifferent_access
      end

      def merge(schema)
        self.class.new data.deep_merge(schema.data)
      end

      def merge!(schema)
        @data = data.deep_merge schema.data
        self
      end
    end
  end
end
