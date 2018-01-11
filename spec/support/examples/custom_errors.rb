module Examples
  class CustomErrors
    include JSON::SchemaBuilder

    def required_error
      lambda do |entities, error|
        if error[:failed_attribute] == "Required"
          required = entities.map(&:required).inject(:+).uniq
          error[:message] = "#{error[:fragment]} requires properties #{required.map(&:to_s).inspect}"
        end
      end
    end

    def object_error
      lambda do |entities, error|
        error[:message] = "Custom object error"
      end
    end

    def example
      object error: required_error do
        object :user, required: true, error: object_error
        object :settings, error: required_error do
          string :name, required: true, error: "Custom name error"
        end
      end
    end

    def example2
      object do
        object :settings, error: required_error do
          string :other, required: true, error: "Other error"
        end
      end
    end

    def any_of
      object do
        entity :user do
          any_of [
            object { object(:settings) { string :name, error: "Nested" } },
            null
          ]
        end
      end
    end
  end
end
