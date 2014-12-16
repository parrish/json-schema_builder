module Examples
  class MixedObjects
    include JSON::SchemaBuilder

    def example
      object do
        object :one, required: true
      end
    end
  end
end
