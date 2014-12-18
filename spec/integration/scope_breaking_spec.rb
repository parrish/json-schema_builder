require 'spec_helper'

RSpec.describe Examples::ScopeBreaking, type: :integration do
  it_behaves_like 'a builder' do
    let(:expected_json) do
      {
        type: :object,
        properties: {
          one: {
            type: :object,
            properties: {
              two: { type: :integer }
            }
          }
        }
      }
    end
  end
end
