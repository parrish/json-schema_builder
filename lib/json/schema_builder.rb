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
    end

    def self.default_options
      @options || { }
    end
  end
end
