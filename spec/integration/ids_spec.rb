require 'spec_helper'

RSpec.describe Examples::Ids, type: :integration do
  it_behaves_like 'a builder' do
    let(:expected_json) do
      {
        type: :object,
        required: [:user_id],
        properties: {
          user_id: {
            oneOf: [
              { type: 'integer', minimum: 1 },
              { type: 'string', pattern: '^[1-9]\d*$' }
            ]
          },
          optional_id: {
            oneOf: [
              { type: 'integer', minimum: 1 },
              { type: 'string', pattern: '^[1-9]\d*$' },
              { type: 'null' }
            ]
          }
        }
      }
    end
  end
end
