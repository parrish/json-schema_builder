module Examples
  class TerseArrays
    include JSON::SchemaBuilder

    def example
      array unique_items: true do
        items type: :string, min_length: 1, max_length: 5, pattern: '^test'
      end
    end
  end
end
