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
    end
  end
end
