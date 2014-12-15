require 'spec_helper'

RSpec.describe JSON::SchemaBuilder::String, type: :unit do
  subject{ described_class }

  it{ is_expected.to define_attribute :min_length }
  it{ is_expected.to define_attribute :max_length }
  it{ is_expected.to define_attribute :pattern }
  its(:registered_type){ is_expected.to eql :string }
end
