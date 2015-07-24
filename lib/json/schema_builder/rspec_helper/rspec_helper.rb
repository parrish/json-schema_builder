module JSON
  module SchemaBuilder
    module RSpecHelper
      extend ::RSpec::SharedContext
      let(:schema_method){ raise 'undefined schema method' }
      let(:schema_context){ { } }
      let(:schema){ described_class.new(schema_context).send schema_method }
      let(:json){ schema.as_json }
      let(:id_schema) do
        {
          oneOf: [
            { type: 'integer', minimum: 1 },
            { type: 'string', pattern: '^[1-9]\d*$' }
          ]
        }
      end
      let(:nullable_id_schema) do
        {
          oneOf: [
            { type: 'integer', minimum: 1 },
            { type: 'string', pattern: '^[1-9]\d*$' },
            { type: 'null' }
          ]
        }
      end
      subject{ DeepOpenStruct.new json }

      def self.included(klass)
        super klass
        klass.send :extend, ClassMethods
      end

      module ClassMethods
        def with(key, &block)
          describe ".#{ key }" do
            eval "def subject; super.#{ key }; end"

            it 'should return an entity' do
              expect(schema).to be_a JSON::SchemaBuilder::Entity
            end

            instance_exec &block
          end
        end
      end
    end
  end
end