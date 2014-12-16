require_relative 'dsl'
require_relative 'schema'
require_relative 'attribute'
require_relative 'validation'

module JSON
  module SchemaBuilder
    class Entity
      include DSL
      include Attribute
      include Validation
      class_attribute :registered_type
      attr_accessor :name, :parent, :children

      attribute :title
      attribute :description

      attribute :type
      attribute :enum, array: true
      attribute :all_of, array: true
      attribute :any_of, array: true
      attribute :one_of, array: true
      attribute :not_a, as: :not
      attribute :definitions

      def initialize(name, opts = { }, &block)
        @name = name
        @children = []
        self.type = self.class.registered_type
        initialize_parent_with opts
        initialize_with opts
        eval_block &block
      end

      def schema
        @schema ||= Schema.new
      end

      def required=(*values)
        @parent.required ||= []
        @parent.required << @name
      end

      def merge_children!
        children.each do |child|
          schema.merge! child.schema
        end
      end

      def as_json
        schema.to_h.as_json
      end

      def respond_to?(method_name, include_all = false)
        if @parent_context
          @parent_context.respond_to? method_name, include_all
        else
          super
        end
      end

      def method_missing(method_name, *args, &block)
        if @parent_context && respond_to?(method_name, true)
          @parent_context.send method_name, *args, &block
        else
          super
        end
      end

      protected

      def initialize_parent_with(opts)
        @parent = opts.delete :parent
        @parent.children << self if @parent
      end

      def initialize_with(opts)
        opts.each_pair do |key, value|
          next if value.nil?
          send :"#{ key }=", value
        end
      end

      def eval_block(&block)
        if block_given?
          @parent_context = block.binding.eval 'self'
          instance_exec self, &block
        end
      end
    end
  end
end
