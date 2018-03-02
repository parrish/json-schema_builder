module JSON
  module SchemaBuilder
    module DSL
      extend ActiveSupport::Concern
      mattr_accessor :types

      def entity(*args, &block)
        opts = args.extract_options!
        klass, name = klass_and_name_from args
        set_context_for opts
        klass.new(name, opts, &block).tap do
          reinitialize if is_a?(Entity)
        end
      end

      protected

      def set_context_for(opts)
        if is_a?(Entity)
          opts[:parent] ||= self
        else
          opts[:root] = self
        end
      end

      def klass_and_name_from(args)
        type, name = args
        if DSL.types[type]
          [DSL.types[type], name]
        else
          [Entity, type]
        end
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
