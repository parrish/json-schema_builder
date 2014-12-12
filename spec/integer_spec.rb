require 'spec_helper'

RSpec.describe JSON::SchemaBuilder::Integer do
  it_behaves_like 'a numeric entity'

  it 'should register' do
    expect(JSON::SchemaBuilder::Integer.registered_type).to eql :integer
  end
end
