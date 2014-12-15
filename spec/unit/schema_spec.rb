require 'spec_helper'

RSpec.describe JSON::SchemaBuilder::Schema, type: :unit do
  let(:schema){ described_class.new a: 1, b: { c: 3 } }
  let(:other){ described_class.new a: 2, b: { d: 4 } }
  it{ is_expected.to be_a OpenStruct }

  describe '#merge' do
    it 'should deep merge' do
      merged = schema.merge other
      expect(merged).to be_a described_class
      expect(merged.to_h).to eql a: 2, b: { c: 3, d: 4 }
    end

    it 'should not modify the source schema' do
      expect{ schema.merge other }.to_not change{ schema.to_h }
    end

    it 'should not modify the merging schema' do
      expect{ schema.merge other }.to_not change{ other.to_h }
    end
  end

  describe '#merge!' do
    it 'should deep merge in place' do
      merged = schema.merge! other
      expect(merged).to be_a described_class
      expect(merged.to_h).to eql a: 2, b: { c: 3, d: 4 }
    end

    it 'should not modify the merging schema' do
      expect{ schema.merge! other }.to_not change { other.to_h }
    end
  end
end
