require 'spec_helper'

RSpec.describe Examples::MixedAnyOfs, type: :integration do
  it_behaves_like 'a builder' do
    let(:expected_json) do
      {
        type: "object",
        properties: {
          blankable: {
            anyOf: [
              { type: "integer" },
              { type: "string" },
              { type: "null" }
            ]
          },
          nullable: {
            anyOf: [
              {
                type: "object",
                properties: {
                  test: {
                    type: "string"
                  }
                }
              },
              { type: "null" }
            ]
          },
          mixed_type: {
            anyOf: [
              {
                type: "object",
                properties: {
                  property: {
                    type: "string"
                  }
                }
              },
              {
                type: "array",
                items: {
                  type: "object",
                  properties: {
                    property: {
                      type: "string"
                    }
                  }
                }
              },
              {
                type: "string",
              },
              {
                type: "null"
              }
            ]
          },
          flexible: {
            anyOf: [
              { type: "string", minLength: 100 },
              { type: "string", maxLength: 0 },
              { type: "integer" },
              {
                type: "object",
                properties: {
                  one: {
                    type: "string"
                  }
                }
              },
              {
                type: "array",
                items: {
                  type: "object",
                  properties: {
                    one: {
                      type: "string"
                    }
                  }
                }
              },
              { type: "null" },
            ]
          },
        }
      }
    end
  end
end
