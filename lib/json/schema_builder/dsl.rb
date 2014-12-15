module JSON
  module SchemaBuilder
    module DSL
      extend ActiveSupport::Concern
      mattr_accessor :types

      included do
        class_attribute :registered_type
      end

      def entity(type, name, opts = { }, &block)
        opts[:parent] ||= self if is_a?(Entity)
        DSL.types[type].new name, opts, &block
      end

      module ClassMethods
        def register(type)
          self.registered_type = type
          DSL.types ||= { }
          DSL.types[type] = self

          DSL.module_eval do
            define_method type do |*args, &block|
              opts = args.extract_options!
              name = args.first
              entity type, name, opts, &block
            end
          end
        end
      end
    end
  end
end
