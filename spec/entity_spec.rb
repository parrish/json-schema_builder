require 'spec_helper'

RSpec.describe JSON::SchemaBuilder::Entity do
  subject{ JSON::SchemaBuilder::Entity }

  it{ is_expected.to define_attribute :title }
  it{ is_expected.to define_attribute :description }
  it{ is_expected.to define_attribute :type }
  it{ is_expected.to define_attribute :enum }
  it{ is_expected.to define_attribute :all_of }
  it{ is_expected.to define_attribute :any_of }
  it{ is_expected.to define_attribute :one_of }
  it{ is_expected.to define_attribute :not }
  it{ is_expected.to define_attribute :definitions }

  describe '.attribute' do
    include_context 'an entity'

    it 'should define the attribute' do
      expect(klass).to define_attribute :test
    end

    it 'should delegate the reader to the schema' do
      subject.schema.test = 1
      expect(subject.test).to eql 1
    end

    it 'should delegate the writer to the schema' do
      subject.test = 1
      expect(subject.schema.test).to eql 1
    end

    it 'should accept function-style writes' do
      subject.test 1
      expect(subject.test).to eql 1
    end

    it 'should snakeCase attribute reads' do
      subject.schema.testName = 1
      expect(subject.test_name).to eql 1
    end

    it 'should snakeCase attribute writes' do
      subject.test_name = 1
      expect(subject.schema.testName).to eql 1
    end
  end

  describe '#initialize' do
    include_context 'an entity with a parent'

    it 'should assign the name' do
      expect(subject.name).to eql 'name'
    end

    it 'should assign option attributes' do
      expect(subject.title).to eql 'test'
    end

    it 'should accept a parent' do
      expect(subject.parent).to eql parent
    end

    it 'should assign itself as a child to the parent' do
      expect(parent.children).to include subject
    end

    it 'should evaluate a block' do
      expect(subject.schema.evaluated_block).to be true
    end
  end

  describe '#required=' do
    include_context 'an entity with a parent'

    it 'should delegate to the parent entity' do
      expect{
        subject.required = 'name'
      }.to change{
        parent.required
      }.to ['name']
    end
  end

  describe '#as_json' do
    include_context 'an entity'

    it 'should delegate to schema' do
      expect(subject.schema).to receive_message_chain :'to_h.as_json'
      subject.as_json
    end
  end
end
