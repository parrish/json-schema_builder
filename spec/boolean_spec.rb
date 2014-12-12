require 'spec_helper'

RSpec.describe JSON::SchemaBuilder::Boolean do
  subject{ described_class }
  its(:registered_type){ is_expected.to eql :boolean }
end
