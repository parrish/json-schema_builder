require 'spec_helper'

RSpec.describe Examples::ArrayAnyOf, type: :integration do
  it_behaves_like 'a builder' do
    let(:expected_json) do
      {
        type: :object,
        properties: {
          an_array: {
            type: :array,
            items: {
              anyOf: [
                {
                  type: :object,
                  properties: {
                    a_string: {
                      type: :string
                    }
                  }
                },
                {
                  type: :object,
                  properties: {
                    a_number: {
                      type: :number
                    }
                  }
                }
              ]
            }
          }
        }
      }
    end
  end
end
