require_relative 'dsl'
require_relative 'schema'
require_relative 'attribute'
require_relative 'validation'
require_relative 'helpers'

module JSON
  module SchemaBuilder
    class Entity
      include DSL
      include Attribute
      include Validation
      include Helpers
      class_attribute :registered_type
      attr_accessor :name, :parent, :children, :options, :fragment, :fragments, :error

      attribute :title
      attribute :description

      attribute :type
      attribute :default
      attribute :enum, array: true
      attribute :all_of, array: true
      attribute :any_of, array: true
      attribute :one_of, array: true
      attribute :not_a, as: :not
      attribute :ref, as: :$ref
      attribute :definitions

      def self.disable_attributes!(*attributes)
        attributes.each do |attr|
          undef_method attr rescue NameError
          undef_method "#{attr}=" rescue NameError
        end
      end

      def initialize(name, opts = { }, &block)
        @name = name
        @children = []
        @fragments = Hash.new { |hash, key| hash[key] = ::Array.new }
        @fragments["#/"] << self if opts[:root]
        self.type = self.class.registered_type
        initialize_parent_with opts
        initialize_with opts
        eval_block &block
        extract_types
      end

      def add_fragment(child)
        @fragments[child.fragment] << child
        @parent.add_fragment(child) if @parent
      end

      def schema
        @schema ||= Schema.new({}, self)
      end

      def required
        schema["required"] || []
      end

      def required=(*values)
        @parent.schema["required"] ||= []
        @parent.schema["required"] << @name
      end

      def merge_children!
        children.each do |child|
          schema.merge! child.schema
        end
      end

      def as_json
        schema.as_json
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

      def extract_types
        any_of(null) if @nullable
        if any_of.present?
          everything_else = schema.data.reject { |k, v| k == "anyOf" }
          return unless everything_else.present?
          schema.data.select! { |k, v| k == "anyOf" }
          schema.data["anyOf"].unshift everything_else
        end
      end

      def initialize_parent_with(opts)
        @parent = opts.delete :parent
        if parent
          @fragment = [@parent.fragment, name].compact.join("/").gsub(%r(//), "/")
          parent.children << self
          parent.add_fragment(self)
        else
          @fragment = "#/"
        end
      end

      def initialize_with(opts)
        @nullable = opts.delete :null
        @options = opts.delete(:root).class.options.to_h if opts[:root]
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
