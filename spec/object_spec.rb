require 'spec_helper'

RSpec.describe JSON::SchemaBuilder::Object do
  subject{ described_class }
  it_behaves_like 'a container entity'

  it{ is_expected.to define_attribute :required }
  it{ is_expected.to define_attribute :min_properties }
  it{ is_expected.to define_attribute :max_properties }
  it{ is_expected.to define_attribute :properties }
  it{ is_expected.to define_attribute :additional_properties }
  it{ is_expected.to define_attribute :pattern_properties }

  describe '#initialize' do
    subject do
      described_class.new 'name' do
        string :test1
        string :test2
      end
    end

    let(:string){ kind_of JSON::SchemaBuilder::String }
    its(:children){ is_expected.to include string }
    its('children.length'){ is_expected.to eql 2 }
    its(:properties){ is_expected.to eql test1: { }, test2: { } }
  end
end
