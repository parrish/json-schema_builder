require 'spec_helper'

RSpec.describe Examples::ContextDelegation, type: :integration do
  [:example, :alternate_example].each do |method_name|
    context 'with an admin' do
      it_behaves_like 'a builder' do
        let(:schema_method){ method_name }
        let(:schema_context) do
          {
            user: Examples::ContextDelegation::User.new(role: :admin)
          }
        end

        let(:expected_json) do
          {
            type: :object,
            additionalProperties: false,
            properties: {
              name: { type: :string },
              role: { type: :string }
            }
          }
        end
      end
    end

    context 'with a user' do
      it_behaves_like 'a builder' do
        let(:schema_method){ method_name }
        let(:schema_context) do
          {
            user: Examples::ContextDelegation::User.new(role: :user)
          }
        end

        let(:expected_json) do
          {
            type: :object,
            additionalProperties: false,
            properties: {
              name: { type: :string }
            }
          }
        end
      end
    end
  end
end
