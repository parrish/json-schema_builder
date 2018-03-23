module Examples
  class CustomErrors
    include JSON::SchemaBuilder

    def required_error
      lambda do |entities, error|
        if error[:failed_attribute] == "Required"
          required = entities.map(&:required).compact.inject(:+).uniq
          error[:message] = "#{error[:fragment]} requires properties #{required.map(&:to_s).inspect}"
        end
      end
    end

    def type_error(message)
      lambda do |entities, error|
        if error[:failed_attribute].start_with?("Type")
          error[:message] = message
        end
      end
    end

    def example
      object error: required_error do
        object :user, required: true, error: type_error("Custom object error")
        object :settings, error: required_error do
          string :name, required: true, error: type_error("Custom name error")
        end
      end
    end

    def example2
      object do
        object :settings, error: required_error do
          string :other, required: true, error: type_error("Other error")
        end
      end
    end

    def example3
      object do
        object :settings, required: true, error: "Settings is required" do
          string :name, required: true, error: "Name is required"
          string :other, required: true, error: "Other is required"
        end
      end
    end

    def any_of
      object do
        entity :user do
          any_of [
            object(:ignored) { object(:settings) { string :name, error: "Nested" } },
            null
          ]
        end
      end
    end
  end
end
