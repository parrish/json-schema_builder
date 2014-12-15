module Examples
  class TerseObjects
    include JSON::SchemaBuilder

    def example
      object do
        string :name, min_length: 1
        array :ids, min_items: 1 do
          items type: :object do
            integer :id, required: true
          end
        end
      end
    end
  end
end
