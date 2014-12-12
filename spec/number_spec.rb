require 'spec_helper'

RSpec.describe JSON::SchemaBuilder::Number do
  it_behaves_like 'a numeric entity'

  it 'should register' do
    expect(JSON::SchemaBuilder::Number.registered_type).to eql :number
  end
end
