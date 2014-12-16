require 'spec_helper'

RSpec.describe Examples::ObjectDefinitions, type: :integration do
  it_behaves_like 'a builder' do
    let(:expected_json) do
      {
        type: :object,
        definitions: {
          positiveInt: {
            type: :integer,
            minimum: 0,
            exclusiveMinimum: true
          }
        },
        properties: {
          one: {
            :$ref => '#/definitions/positiveInt'
          }
        }
      }
    end
  end
end
