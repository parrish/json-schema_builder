module Examples
  class ContinuousBuilding
    include JSON::SchemaBuilder

    def base
      object
    end

    def extended
      obj = base
      obj.string :title
      obj
    end
  end
end
