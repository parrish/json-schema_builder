require 'spec_helper'

RSpec.describe JSON::SchemaBuilder::Object, type: :unit do
  subject{ described_class }

  it{ is_expected.to define_attribute :required }
  it{ is_expected.to define_attribute :min_properties }
  it{ is_expected.to define_attribute :max_properties }
  it{ is_expected.to define_attribute :properties }
  it{ is_expected.to define_attribute :additional_properties }
  it{ is_expected.to define_attribute :pattern_properties }
  its(:registered_type){ is_expected.to eql :object }

  describe '#initialize' do
    subject do
      described_class.new 'name' do
        string :test1
        string :test2
        string /^_/
        string /^\./
      end
    end

    let(:string){ kind_of JSON::SchemaBuilder::String }
    its(:children){ is_expected.to include string }
    its('children.length'){ is_expected.to eql 4 }
    its('properties'){ is_expected.to include test1: { 'type' => 'string' } }
    its('properties'){ is_expected.to include test2: { 'type' => 'string' } }
    its('pattern_properties'){ is_expected.to include '^_' => { 'type' => 'string' } }
    its('pattern_properties'){ is_expected.to include '^\.' => { 'type' => 'string' } }
  end

  describe "#required" do
    subject do
      described_class.new 'name' do
        string :test1, required: true
        string :test2, required: false
        string :test2, required: nil
      end
    end

    its(:required) { is_expected.to match_array([:test1]) }
  end
end
