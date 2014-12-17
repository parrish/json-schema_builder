require 'pry'
require 'simplecov'
SimpleCov.configure do
  add_filter '/lib/json/schema_builder/rspec_helper'
  add_filter '/spec'
end

SimpleCov.start

%w(lib spec/support).each do |path|
  Dir["./#{ path }/**/*.rb"].sort.each{ |file| require file }
end

require 'rspec/its'
RSpec.configure do |config|
  config.disable_monkey_patching!
  config.include IntegrationHelper, type: :integration
end
