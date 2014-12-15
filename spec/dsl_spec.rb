require 'spec_helper'

RSpec.describe JSON::SchemaBuilder::DSL do
  let!(:klass) do
    Class.new do
      include JSON::SchemaBuilder::DSL
      register :something
      def initialize(*args); end
    end
  end
  let(:instance){ klass.new }

  describe '.register' do
    it 'should register the class' do
      expect(subject.types).to have_key :something
      expect(subject.types[:something]).to eql klass
    end

    it 'should store the registered type' do
      expect(klass.registered_type).to eql :something
    end

    context 'with a type method' do
      it 'should generate' do
        expect(instance).to respond_to :something
      end

      it 'should dispatch to entity' do
        expect(instance).to receive(:entity).with(:something, 1, foo: :bar).and_call_original
        instance.something 1, foo: :bar
      end

      it 'should allow unnamed entities' do
        expect(instance).to receive(:entity).with(:something, nil, foo: :bar).and_call_original
        instance.something foo: :bar
      end
    end
  end

  describe '#entity' do
    context 'without an entity' do
      it 'should create the type' do
        expect(instance.class).to receive(:new)
          .with('name', { }).and_call_original

        entity = instance.entity :something, 'name'
        expect(entity).to be_a klass
      end
    end

    context 'with an entity' do
      let!(:klass) do
        Class.new JSON::SchemaBuilder::Entity do
          include JSON::SchemaBuilder::DSL
          register :something
          def initialize(*args); end
        end
      end

      it 'should set the parent' do
        expect(instance.class).to receive(:new)
          .with('name', parent: kind_of(klass)).and_call_original

        entity = instance.entity :something, 'name'
        expect(entity).to be_a klass
      end
    end
  end
end
