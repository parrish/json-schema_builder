module Examples
  class ObjectDefinitions
    include JSON::SchemaBuilder

    def example
      object do
        definitions positiveInt: positive_int
        entity :one, ref: '#/definitions/positiveInt'
      end
    end

    def positive_int
      integer do
        minimum 0
        exclusive_minimum true
      end
    end
  end
end
