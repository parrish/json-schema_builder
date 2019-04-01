require 'spec_helper'

RSpec.describe Examples::ExpandNullTrue, type: :integration do
  it_behaves_like 'a builder' do
    let(:expected_json) do
      {
        "type": "object",
        "required": [
          "foo"
        ],
        "properties": {
          "foo": {
            "type": "object",
            "required": [
              "bar"
            ],
            "properties": {
              "bar": {
                "anyOf": [
                  {
                    "type": "object",
                    "properties": {
                      "baz": {
                        "type": "string"
                      }
                    }
                  },
                  {
                    "type": "null"
                  }
                ]
              }
            }
          }
        }
      }
    end
  end
end
