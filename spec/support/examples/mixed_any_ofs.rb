module Examples
  class MixedAnyOfs
    include JSON::SchemaBuilder

    def example
      object do
        integer :blankable, any_of: [string], null: true

        object :nullable, null: true do
          string :test
        end

        object_or_array :mixed_type, any_of: [string, null], null: true do
          string :property
        end

        entity :flexible, any_of: [string(min_length: 100), empty_string, integer], null: true do
          any_of [
            an_object(self),
            array { items { an_object(self) } }
          ]
        end
      end
    end

    def an_object(root)
      root.object do
        string :one
      end
    end
  end
end
