require 'spec_helper'

RSpec.describe JSON::SchemaBuilder::Entity, type: :unit do
  subject{ described_class }

  it{ is_expected.to define_attribute :title }
  it{ is_expected.to define_attribute :description }
  it{ is_expected.to define_attribute :type }
  it{ is_expected.to define_attribute :default }
  it{ is_expected.to define_attribute :enum }
  it{ is_expected.to define_attribute :all_of }
  it{ is_expected.to define_attribute :any_of }
  it{ is_expected.to define_attribute :one_of }
  it{ is_expected.to define_attribute :not_a }
  it{ is_expected.to define_attribute :ref }
  it{ is_expected.to define_attribute :definitions }

  describe ".disable_attributes!" do
    let(:disabled_attributes) { [:default, :ref, :definitions] }

    around(:each) do |example|
      described_class.disable_attributes! *disabled_attributes
      example.call
      disabled_attributes.each { |attr| described_class.attribute(attr) }
    end

    it "should remove the attribute methods" do
      entity = described_class.new "test"
      disabled_attributes.each do |attr|
        expect(entity).to_not respond_to(attr)
        expect(entity).to_not respond_to("#{attr}=")
      end
    end
  end

  describe '.attribute' do
    include_context 'an entity'

    it 'should define the attribute' do
      expect(klass).to define_attribute :test
    end

    it 'should delegate the reader to the schema' do
      subject.schema[:test] = 1
      expect(subject.test).to eql 1
    end

    it 'should delegate the writer to the schema' do
      subject.schema[:test] = 1
      expect(subject.schema[:test]).to eql 1
    end

    it 'should accept function-style writes' do
      subject.test 1
      expect(subject.test).to eql 1
    end

    it 'should snakeCase attribute reads' do
      subject.schema[:testName] = 1
      expect(subject.test_name).to eql 1
    end

    it 'should snakeCase attribute writes' do
      subject.test_name = 1
      expect(subject.schema[:testName]).to eql 1
    end

    it 'should handle array argument reads' do
      subject.schema[:testList] = [1, 2, 3]
      expect(subject.test_list).to eql [1, 2, 3]
    end

    it 'should handle array argument writes' do
      subject.test_list = [1, 2, 3]
      expect(subject.schema[:testList]).to eql [1, 2, 3]
    end

    it 'should handle array argument lists' do
      subject.test_list 1, 2, 3
      expect(subject.schema[:testList]).to eql [1, 2, 3]
    end

    it 'should handle arbitrary key writes' do
      subject.test_as 1
      expect(subject.schema[:testAs]).to be_nil
      expect(subject.schema[:testOther]).to eql 1
    end

    it 'should handle arbitrary key reads' do
      subject.schema[:testOther] = 1
      expect(subject.test_as).to eql 1
    end
  end

  describe '#initialize' do
    include_context 'an entity with a parent'

    its(:name){ is_expected.to eql 'name' }
    its(:title){ is_expected.to eql 'test' }
    its(:parent){ is_expected.to eql parent }
    its('schema.data'){ is_expected.to include evaluated_block: true }
    its('parent.children'){ is_expected.to include subject }
  end

  describe '#required=' do
    include_context 'an entity with a parent'

    it 'should delegate to the parent entity' do
      expect{
        subject.required = 'name'
      }.to change{
        parent.required
      }.from([]).to ['name']
    end
  end

  %w(validate validate! fully_validate).each do |validator|
    describe "##{ validator }" do
      let(:klass) do
        Class.new do
          include JSON::SchemaBuilder
          configure{ |opts| opts.working = true }

          def example
            object{ string :name }
          end
        end
      end
      subject{ klass.new.example }

      it "should #{ validator }" do
        expect(JSON::Validator).to receive(validator)
          .with subject.as_json, { }, working: true, opts: true
        subject.send validator, { }, opts: true
      end
    end
  end

  describe '#merge_children!' do
    include_context 'an entity with a parent'

    let(:child_schema){ double 'JSON::SchemaBuilder::Schema' }
    let(:child){ double 'JSON::SchemaBuilder::Entity', schema: child_schema }

    it 'should merge children schemas' do
      expect(child).to receive :schema
      expect(subject).to receive(:children).and_return [child]
      expect(subject.schema).to receive(:merge!).with child_schema
      subject.merge_children!
    end
  end

  describe '#as_json' do
    include_context 'an entity'

    it 'should delegate to schema' do
      expect(subject.schema).to receive(:as_json)
      subject.as_json
    end
  end

  describe "array attributes" do
    let(:klass) do
      Class.new do
        include JSON::SchemaBuilder

        def example
          object do
            object :parent_name do
              any_of [
                string(:name)
              ]
            end
          end
        end
      end
    end
    subject(:schema){ klass.new }

    it "prevents elements from being named" do
      expect(schema.example.fragments.keys).to match_array(%w(#/ #/parent_name))
    end
  end
end
