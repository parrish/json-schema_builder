require 'spec_helper'

RSpec.describe Examples::MixedArrays, type: :integration do
  it_behaves_like 'a builder' do
    let(:expected_json) do
      {
        type: :array,
        items: {
          type: :array,
          items: [{ }, { }],
          additionalItems: false
        }
      }
    end
  end
end
