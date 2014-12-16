require 'spec_helper'

RSpec.describe Examples::SchemaBuilder, type: :integration do
  types = %w(array boolean integer null number object string)

  types.each do |type|
    describe "##{ type }" do
      let(:klass){ "JSON::SchemaBuilder::#{ type.classify }".constantize }

      it "should register #{ type } type" do
        expect(subject.types[type.to_sym]).to be klass
      end

      it "should define a #{ type } method" do
        expect(subject).to respond_to type.to_sym
      end
    end
  end

  describe '#initialize' do
    it 'should assign context' do
      instance = Examples::SchemaBuilder.new a: 1, b: 2
      expect(instance.as_json).to eql 'a' => 1, 'b' => 2
    end
  end

  describe 'Configuration' do
    subject{ Examples::SchemaBuilder }
    after(:all) do
      JSON::SchemaBuilder.configure
      Examples::SchemaBuilder.configure
    end

    describe '.options=' do
      before(:each){ subject.options = { a: 1 } }

      its(:options){ is_expected.to be_a OpenStruct }
      its('options.to_h'){ is_expected.to eql a: 1 }
    end

    describe '.configure' do
      before(:each) do
        subject.configure{ |opts| opts.validate_schema = true }
      end

      its(:options){ is_expected.to be_a OpenStruct }
      its('options.to_h'){ is_expected.to eql validate_schema: true }

      context 'with default options' do
        after(:each){ subject.configure }
        before(:each) do
          JSON::SchemaBuilder.configure do |opts|
            opts.insert_defaults = true
            opts.validate_schema = false
          end

          subject.configure do |opts|
            opts.validate_schema = true
          end
        end

        its('options.insert_defaults'){ is_expected.to be true }
        its('options.validate_schema'){ is_expected.to be true }
      end

      it 'should reset configuration first' do
        subject.configure
        expect(subject.options.validate_schema).to be nil
      end

      it 'should pass options to root entities' do
        entity = subject.new.example
        expect(entity.options).to eql validate_schema: true
      end

      it 'should not pass options to child entities' do
        entity = subject.new.example.children.first
        expect(entity.options).to be nil
      end
    end
  end
end
