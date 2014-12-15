require 'spec_helper'

RSpec.describe JSON::SchemaBuilder::Null, type: :unit do
  subject{ described_class }
  its(:registered_type){ is_expected.to eql :null }
end
