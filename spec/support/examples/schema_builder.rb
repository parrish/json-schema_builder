module Examples
  class SchemaBuilder
    include JSON::SchemaBuilder

    configure do |opts|
      opts.validate_schema = true
    end

    def example
      object do
        string :name, required: true
      end
    end
  end
end
