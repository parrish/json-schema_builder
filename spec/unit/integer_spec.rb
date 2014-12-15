require 'spec_helper'

RSpec.describe JSON::SchemaBuilder::Integer, type: :unit do
  subject{ described_class }
  it_behaves_like 'a numeric entity'
  its(:registered_type){ is_expected.to eql :integer }
end
