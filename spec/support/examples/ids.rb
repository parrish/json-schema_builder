module Examples
  class Ids
    include JSON::SchemaBuilder

    def example
      object do
        id :user_id, required: true
        id :optional_id, null: true
        id :an_id
        id :a_nullable_id, null: true
      end
    end
  end
end
