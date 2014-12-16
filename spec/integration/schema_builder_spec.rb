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

  describe 'Configuration' do
    describe '.configure' do
      subject{ Examples::SchemaBuilder }
      its(:options){ is_expected.to be_a OpenStruct }
      its('options.to_h'){ is_expected.to eql validate_schema: true }

      context 'with default options' do
        after(:all){ JSON::SchemaBuilder.configure }
        before(:all) do
          JSON::SchemaBuilder.configure do |opts|
            opts.insert_defaults = true
            opts.validate_schema = false
          end

          Examples::SchemaBuilder.configure do |opts|
            opts.validate_schema = true
          end
        end

        its('options.insert_defaults'){ is_expected.to be true }
        its('options.validate_schema'){ is_expected.to be true }
      end
    end
  end
end
