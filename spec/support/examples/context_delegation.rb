module Examples
  class ContextDelegation
    include JSON::SchemaBuilder
    delegate :admin?, to: :@user

    def example
      object additional_properties: false do
        string :name
        string :role if admin?
      end
    end

    class User < OpenStruct
      def admin?
        role == :admin
      end
    end
  end
end
