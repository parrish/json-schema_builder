module IntegrationHelper
  extend RSpec::SharedContext
  let(:schema_context){ { } }
  let(:schema){ described_class.new(schema_context).example }
  let(:json){ schema.as_json }
  let(:expected_json){ { } }

  RSpec.shared_examples_for 'a builder' do
    it 'should produce the correct json schema' do
      expect(json).to eql expected_json.as_json
    end
  end
end
