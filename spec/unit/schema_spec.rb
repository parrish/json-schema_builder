require 'spec_helper'

RSpec.describe JSON::SchemaBuilder::Schema, type: :unit do
  let(:schema){ described_class.new a: 1, b: { c: 3 }, array: [123, { foo: 1, bar: { baz: 0 }}] }
  let(:other){ described_class.new a: 2, "b" => { d: 4 }, array: [456, { foo: 2, bar: { qux: 1 }}] }
  let(:merged) do
    {
      "a" => 2,
      "b" => {
        "c" => 3,
        "d" => 4
      },
      "array" => [
        123, {
          "foo" => 1,
          "bar" => {
            "baz" => 0,
          }
        },
        456, {
          "foo" => 2,
          "bar" => {
            "qux" => 1
          }
        }
      ]
    }
  end

  its(:data){ is_expected.to be_a(HashWithIndifferentAccess) }

  describe '#merge' do
    it 'should deep merge' do
      merged_schema = schema.merge other
      expect(merged_schema).to be_a described_class
      expect(merged_schema.data).to eql merged
    end

    it 'should not modify the source schema' do
      expect{ schema.merge other }.to_not change{ schema.data }
    end

    it 'should not modify the merging schema' do
      expect{ schema.merge other }.to_not change{ other.data }
    end
  end

  describe '#merge!' do
    it 'should deep merge in place' do
      merged_schema = schema.merge! other
      expect(merged_schema).to be_a described_class
      expect(merged_schema.data).to eql merged
    end

    it 'should not modify the merging schema' do
      expect{ schema.merge! other }.to_not change { other.data }
    end
  end
end
