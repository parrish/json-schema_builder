module Examples
  class ContextDelegation
    include JSON::SchemaBuilder
    attr_accessor :user
    delegate :admin?, to: :@user

    def example
      object additional_properties: false do
        string :name
        string :role if admin?
      end
    end

    def alternate_example
      object additional_properties: false do
        string :name
        string :role if user.admin?
      end
    end

    class User < OpenStruct
      def admin?
        role == :admin
      end
    end
  end
end
