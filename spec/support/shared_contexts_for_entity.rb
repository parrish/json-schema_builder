require 'spec_helper'

RSpec.shared_context 'an entity' do
  let(:klass) do
    Class.new JSON::SchemaBuilder::Entity do
      attribute :test
      attribute :test_name
      attribute :test_list, array: true
      attribute :test_as, as: :testOther
      def initialize(*args); end
    end
  end

  subject{ klass.new }
end

RSpec.shared_context 'an entity with a parent' do
  let(:parent){ OpenStruct.new children: [], required: [] }
  subject do
    JSON::SchemaBuilder::Entity.new 'name', title: 'test', parent: parent do
      schema.evaluated_block = true
    end
  end
end
