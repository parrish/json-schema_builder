module JSON
  module SchemaBuilder
    class Entity
      include DSL
      class_attribute :registered_type
      attr_accessor :name, :parent

      def self.attribute(name)
        as_name = name.to_s.underscore.gsub(/_(\w)/){ $1.upcase }
        define_method name do |value = nil|
          if value.nil?
            self.schema[as_name]
          else
            self.schema[as_name] = value
          end
        end
        alias_method "#{ name }=", name
      end

      attribute :title
      attribute :description

      attribute :type
      attribute :enum
      attribute :all_of
      attribute :any_of
      attribute :one_of
      attribute :not
      attribute :definitions

      def initialize(name, opts = { }, &block)
        @name = name
        @type = self.class.registered_type
        initialize_parent_with opts
        initialize_with opts
        eval_block &block
      end

      def schema
        @schema ||= OpenStruct.new
      end

      def required=(*values)
        @parent.required ||= []
        @parent.required << @name
      end

      def as_json
        schema.to_h.as_json
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
        instance_exec(self, &block) if block_given?
      end
    end
  end
end
