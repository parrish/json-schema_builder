require 'spec_helper'

RSpec.describe Examples::VerboseObjects, type: :integration do
  include JSON::SchemaBuilder::RSpecHelper
  let(:schema_method){ :example }
  its(:type){ is_expected.to eql 'object' }

  with :properties do
    its(:name){ is_expected.to eql type: 'string', minLength: 1 }

    with :ids do
      its(:type){ is_expected.to eql 'array' }
      its(:minItems){ is_expected.to eql 1 }

      with :items do
        its(:type){ is_expected.to eql 'object' }
        its(:required){ is_expected.to eql ['id'] }
        its('properties.id.type'){ is_expected.to eql 'integer' }
      end
    end
  end
end
