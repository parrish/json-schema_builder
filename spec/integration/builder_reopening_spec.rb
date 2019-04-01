require 'spec_helper'

RSpec.describe Examples::BuilderReopening, type: :integration do
  it_behaves_like 'a builder' do
    let(:expected_json) do
      {
        type: :object,
        properties: {
          name: {
            type: :string
          },
          settings: {
            type: :object,
            properties: {
              email: {
                type: :string
              },
              phone_number: {
                type: :string
              }
            }
          },
          target: {
            anyOf: [
              {
                type: :object,
                properties: {
                  id: {
                    type: :number
                  }
                }
              },
              {
                type: :null
              }
            ]
          },
          preferences: {
            anyOf: [
              {
                type: :object,
                properties: {
                  enabled: {
                    type: :boolean,
                    default: true
                  }
                }
              },
              {
                type: :null
              }
            ]
          },
          ids: {
            type: :array,
            items: {
              type: :string,
            }
          }
        }
      }
    end
  end
end
