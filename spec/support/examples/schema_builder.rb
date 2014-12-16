module Examples
  class SchemaBuilder
    include JSON::SchemaBuilder

    def example
      object do
        string :name, required: true
      end
    end
  end
end
