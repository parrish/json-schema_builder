require_relative 'entity'

module JSON
  module SchemaBuilder
    class ContainerEntity < Entity
      attr_accessor :children

      def initialize(name, opts = { }, &block)
        @children = []
        super
      end

      def merge_children!
        children.each do |child|
          schema.merge! child.schema
        end
      end
    end
  end
end
