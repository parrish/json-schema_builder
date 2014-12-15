require_relative 'container_entity'

module JSON
  module SchemaBuilder
    class Array < ContainerEntity
      register :array
      attribute :additional_items
      attribute :min_items
      attribute :max_items
      attribute :unique_items

      def items(opts = { }, &block)
        schema.items = items_entity(opts, &block).as_json
      end

      protected

      def items_entity(opts, &block)
        if opts[:type]
          send opts.delete(:type), opts, &block
        else
          ContainerEntity.new(nil, opts, &block).tap &:merge_children!
        end
      end
    end
  end
end
