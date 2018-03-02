module Examples
  class ArrayAnyOf
    include JSON::SchemaBuilder

    def example
      object do
        array :an_array do
          items do
            any_of [
              object { string(:a_string) },
              object { number(:a_number) }
            ]
          end
        end
      end
    end
  end
end
