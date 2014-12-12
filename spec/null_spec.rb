require 'spec_helper'

RSpec.describe JSON::SchemaBuilder::Null do
  subject{ described_class }
  its(:registered_type){ is_expected.to eql :null }
end
