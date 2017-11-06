module JSON
  module SchemaBuilder
    module Helpers
      def id(name, opts = { }, &block)
        nullable = opts.delete :null
        entity name, opts do |child|
          types = [
            integer(minimum: 1),
            string(pattern: '^[1-9]\d*$')
          ]
          types << null if nullable
          one_of types
          child.eval_block &block
        end
      end

      def object_or_array(*args, &block)
        opts = args.extract_options!
        name = args.shift
        nullable = opts.delete :null

        entity name do
          list = [
            object(*args, opts) { |child| child.eval_block(&block) },
            array {
              items {
                object(*args, opts) { |child| child.eval_block(&block) }
              }
            }
          ]

          list << null if nullable
          any_of list
        end
      end
    end
  end
end
