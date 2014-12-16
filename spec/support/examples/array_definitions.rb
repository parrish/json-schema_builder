module Examples
  class ArrayDefinitions
    include JSON::SchemaBuilder

    def example
      array do
        definitions positiveInt: positive_int
        items ref: '#/definitions/positiveInt'
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
