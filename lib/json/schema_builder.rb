require 'active_support'
require 'active_support/core_ext'
require 'json/schema_builder/dsl'
require 'json/schema_builder/version'

%w(array boolean integer null number object string).each do |type|
  require "json/schema_builder/#{ type }"
end

module JSON
  module SchemaBuilder
    include DSL
  end
end
