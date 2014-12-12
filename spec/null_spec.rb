require 'spec_helper'

RSpec.describe JSON::SchemaBuilder::Null do
  it 'should register' do
    expect(JSON::SchemaBuilder::Null.registered_type).to eql :null
  end
end
