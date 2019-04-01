module Examples
  class NestedNullable
    include JSON::SchemaBuilder

    def example
      object.tap do |base_obj|
        obj = base_obj.object :nullable_object, null: true
        obj.string :nullable_string, null: true
      end
    end
  end
end
