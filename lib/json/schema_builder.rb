require 'active_support'
require 'active_support/core_ext'
require 'json/schema_builder/dsl'
require 'json/schema_builder/version'
require 'json/schema_builder/configuration'

%w(array boolean integer null number object string).each do |type|
  require "json/schema_builder/#{ type }"
end

module JSON
  module SchemaBuilder
    extend ActiveSupport::Concern
    include DSL
    extend JSON::SchemaBuilder::Configuration

    included do |klass|
      extend JSON::SchemaBuilder::Configuration
      class << self
        attr_accessor :root_key
      end
    end

    def self.default_options
      @options || { }
    end

    def initialize(context = { })
      context.each_pair do |key, value|
        instance_variable_set "@#{ key }", value
      end
    end

    def root(key = nil, &block)
      root_key = key || self.class.root_key.to_sym
      object do
        object root_key, required: true, &block
      end
    end

    module ClassMethods
      def root(key)
        @root_key = key
      end
    end
  end
end
