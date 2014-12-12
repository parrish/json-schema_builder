require_relative 'entity'

module JSON
  module SchemaBuilder
    class ContainerEntity < Entity
      attr_accessor :children

      def initialize(name, opts = { }, &block)
        @children = []
        super
      end
    end
  end
end
