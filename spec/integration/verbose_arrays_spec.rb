require 'spec_helper'

RSpec.describe Examples::VerboseArrays, type: :integration do
  it_behaves_like 'a builder' do
    let(:expected_json) do
      {
        type: :array,
        uniqueItems: true,
        items: {
          type: :string,
          minLength: 1,
          maxLength: 5,
          pattern: '^test'
        }
      }
    end
  end
end
