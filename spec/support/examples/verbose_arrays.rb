module Examples
  class VerboseArrays
    include JSON::SchemaBuilder

    def example
      array do
        unique_items true

        items do
          string do
            min_length 1
            max_length 5
            pattern '^test'
          end
        end
      end
    end
  end
end
