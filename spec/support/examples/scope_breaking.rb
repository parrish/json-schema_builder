module Examples
  class ScopeBreaking
    include JSON::SchemaBuilder

    def example
      object do |parent|
        other_method parent
      end
    end

    def other_method(parent)
      parent.object :one do
        integer :two
      end
    end
  end
end
