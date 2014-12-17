module Examples
  class Rooted
    include JSON::SchemaBuilder

    root :rooted

    def example
      root do
        string :name
      end
    end

    def alternate_root
      root :other_root do
        string :name
      end
    end
  end
end
