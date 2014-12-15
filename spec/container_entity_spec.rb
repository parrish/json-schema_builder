require 'spec_helper'

RSpec.describe JSON::SchemaBuilder::ContainerEntity do
  subject{ described_class.new nil }
  it{ is_expected.to be_a JSON::SchemaBuilder::Entity }

  describe '#initialize' do
    its(:children){ is_expected.to eql [] }
  end

  describe '#merge_children!' do
    let(:child_schema){ double 'JSON::SchemaBuilder::Schema' }
    let(:child){ double 'JSON::SchemaBuilder::Entity', schema: child_schema }

    it 'should merge children schemas' do
      expect(child).to receive :schema
      expect(subject).to receive(:children).and_return [child]
      expect(subject.schema).to receive(:merge!).with child_schema
      subject.merge_children!
    end
  end
end
