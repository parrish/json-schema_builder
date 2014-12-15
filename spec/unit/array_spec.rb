require 'spec_helper'

RSpec.describe JSON::SchemaBuilder::Array, type: :unit do
  subject{ described_class }
  it_behaves_like 'a container entity'

  it{ is_expected.to define_attribute :additional_items }
  it{ is_expected.to define_attribute :min_items }
  it{ is_expected.to define_attribute :max_items }
  it{ is_expected.to define_attribute :unique_items }
  its(:registered_type){ is_expected.to eql :array }

  describe '#items' do
    context 'with a simple array' do
      let(:array) do
        described_class.new 'name' do
          min_items 2
          items type: :string do
            min_length 3
          end
        end
      end

      subject{ array.as_json }
      its(['type']){ is_expected.to eql 'array' }
      its(['minItems']){ is_expected.to eql 2 }
      its(['items']){ is_expected.to eql 'type' => 'string', 'minLength' => 3 }
    end

    context 'with nested structure' do
      let(:array) do
        described_class.new 'name' do
          items do
            object do
              string :key_name, required: true
            end
          end
        end
      end

      subject{ array.as_json }
      its(['type']){ is_expected.to eql 'array' }

      describe 'items' do
        subject{ array.as_json['items'] }
        its(['type']){ is_expected.to eql 'object' }
        its(['required']){ is_expected.to eql ['key_name'] }

        describe "items['properties']" do
          subject{ array.as_json['items']['properties'] }
          its(['key_name']){ is_expected.to eql 'type' => 'string' }
        end
      end
    end
  end
end
