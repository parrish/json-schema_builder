module Examples
  class MixedArrays
    include JSON::SchemaBuilder

    def example
      array do
        items type: :array do
          items [{ }, { }]
          additional_items false
        end
      end
    end
  end
end
