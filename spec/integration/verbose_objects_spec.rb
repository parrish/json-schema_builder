require 'spec_helper'

RSpec.describe Examples::VerboseObjects, type: :integration do
  it_behaves_like 'a builder' do
    let(:expected_json) do
      {
        type: :object,
        properties: {
          name: {
            type: :string,
            minLength: 1
          },
          ids: {
            type: :array,
            minItems: 1,
            items: {
              type: :object,
              required: [:id],
              properties: {
                id: {
                  type: :integer
                }
              }
            }
          }
        }
      }
    end
  end
end
