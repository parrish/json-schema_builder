require 'spec_helper'

RSpec.describe Examples::ContinuousBuilding, type: :integration do
  subject { described_class.new }
  let(:expected_base) do
    {
      type: 'object',
      properties: {}
    }
  end
  let(:expected_extended) do
    expected_base[:properties] = { title: { type: 'string' } }
    expected_base
  end

  describe '#base' do
    let(:schema_method) { :base }
    let(:expected_json) { expected_base }

    it_behaves_like 'a builder'
  end

  describe '#extended' do
    let(:schema_method) { :extended }
    let(:expected_json) { expected_extended }

    it_behaves_like 'a builder'
  end
end
