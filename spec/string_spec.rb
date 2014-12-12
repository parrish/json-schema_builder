require 'spec_helper'

RSpec.describe JSON::SchemaBuilder::String do
  subject{ described_class }

  it{ is_expected.to define_attribute :min_length }
  it{ is_expected.to define_attribute :max_length }
  it{ is_expected.to define_attribute :pattern }

  it 'should register' do
    expect(subject.registered_type).to eql :string
  end
end
