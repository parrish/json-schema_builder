require 'spec_helper'

RSpec.describe Examples::NestedNullable, type: :integration do
  it_behaves_like 'a builder' do
    let(:expected_json) do
      {
        type: 'object',
        properties: {
          nullable_object: {
            anyOf: [
              {
                type: 'object',
                properties: {
                  nullable_string: {
                    anyOf: [
                      {
                        type: 'string'
                      },
                      {
                        type: 'null'
                      }
                    ]
                  }
                }
              },
              {
                type: 'null'
              }
            ]
          }
        }
      }
    end
  end
end
