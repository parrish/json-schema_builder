require 'spec_helper'

RSpec.describe Examples::ArrayDefinitions, type: :integration do
  it_behaves_like 'a builder' do
    let(:expected_json) do
      {
        type: :array,
        definitions: {
          positiveInt: {
            type: :integer,
            minimum: 0,
            exclusiveMinimum: true
          }
        },
        items: {
          :$ref => '#/definitions/positiveInt'
        }
      }
    end
  end
end
