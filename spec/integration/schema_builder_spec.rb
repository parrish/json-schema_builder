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
end
