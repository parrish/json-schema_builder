module Examples
  class VerboseObjects
    include JSON::SchemaBuilder

    def example
      object do
        string :name do
          min_length 1
        end

        array :ids do
          min_items 1

          items do
            object do
              required :id
              integer :id
            end
          end
        end
      end
    end
  end
end
