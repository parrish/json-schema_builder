require 'spec_helper'

RSpec.describe Examples::MixedObjects, type: :integration do
  it_behaves_like 'a builder' do
    let(:expected_json) do
      {
        type: :object,
        required: [:one],
        properties: {
          one: {
            type: :object,
            properties: { }
          }
        }
      }
    end
  end
end
