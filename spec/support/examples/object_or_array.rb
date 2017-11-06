module Examples
  class ObjectOrArray
    include JSON::SchemaBuilder

    def example
      object_or_array additional_properties: false, null: true do
        any :thing

        object_or_array :other, additional_properties: false do
          string :stuff
        end
      end
    end
  end
end
