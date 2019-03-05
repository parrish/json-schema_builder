module Examples
  class BuilderInitialization
    include JSON::SchemaBuilder

    def example
      obj = object
      obj.string :name
      settings_for(obj)
      target_for(obj)
      preferences_for(obj)
      add_ids_to(obj)
      obj
    end

    def target_for(obj)
      target = obj.object :target, null: true
      target.number :id
      target
    end

    def settings_for(obj)
      settings = obj.object :settings
      settings.string :email
      settings
    end

    def preferences_for(obj)
      preferences = obj.entity :preferences
      preferences.any_of preference
      preferences.any_of null
    end

    def preference
      obj = object
      enabled = obj.boolean :enabled
      enabled.default = true
      obj
    end

    def add_ids_to(obj)
      ids = obj.array :ids
      ids.items do
        any_of number
        any_of string
      end
    end
  end
end
