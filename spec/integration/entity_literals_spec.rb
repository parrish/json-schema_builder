require 'spec_helper'

RSpec.describe Examples::EntityLiterals, type: :integration do
  it_behaves_like 'a builder' do
    let(:expected_json) do
      {
        type: :object,
        required: [:one],
        properties: {
          one: {
            enum: [:string, :null]
          },
          two: {
            allOf: [
              { type: :integer, minimum: 1 },
              { type: :string }
            ]
          },
          three: {
            anyOf: [
              { type: :integer, minimum: 1 },
              { type: :null }
            ]
          },
          four: {
            not: {
              type: :null
            }
          },
          five: {
            oneOf: [
              { type: :string },
              { type: :number }
            ]
          }
        }
      }
    end
  end

  it 'should raise through missing methods' do
    expect {
      described_class.new.bad_example
    }.to raise_error NameError
  end
end
