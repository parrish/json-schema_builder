require 'spec_helper'

RSpec.describe JSON::SchemaBuilder::Any, type: :unit do
  subject{ described_class }
  its(:registered_type){ is_expected.to eql :any }
end
