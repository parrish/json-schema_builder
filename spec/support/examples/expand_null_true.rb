module Examples
  class ExpandNullTrue
    include JSON::SchemaBuilder

    def example
      object.tap do |base_obj|
        foo_obj = base_obj.object(:foo, required: true)
        bar_obj = foo_obj.object(:bar, null: true, required: true)
        bar_obj.string :baz
      end
    end
  end
end
