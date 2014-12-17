require 'spec_helper'

RSpec.describe Examples::Rooted, type: :integration do
  context 'with a root key' do
    it_behaves_like 'a builder' do
      let(:expected_json) do
        {
          type: :object,
          required: [:rooted],
          properties: {
            rooted: {
              type: :object,
              properties: {
                name: { type: :string }
              }
            }
          }
        }
      end
    end
  end

  context 'with an alternate root key' do
    it_behaves_like 'a builder' do
      let(:schema_method){ :alternate_root }
      let(:expected_json) do
        {
          type: :object,
          required: [:other_root],
          properties: {
            other_root: {
              type: :object,
              properties: {
                name: { type: :string }
              }
            }
          }
        }
      end
    end
  end
end
