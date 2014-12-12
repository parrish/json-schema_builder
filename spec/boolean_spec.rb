require 'spec_helper'

RSpec.describe JSON::SchemaBuilder::Boolean do
  it 'should register' do
    expect(JSON::SchemaBuilder::Boolean.registered_type).to eql :boolean
  end
end
