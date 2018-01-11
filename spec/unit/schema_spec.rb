require 'spec_helper'

RSpec.describe JSON::SchemaBuilder::Schema, type: :unit do
  subject(:schema) do
    Class.new do
      include JSON::SchemaBuilder

      def example
        object do
          integer :a

          object :b do
            integer :c
          end

          array :array do
            items do
              object do
                integer :foo

                object :bar do
                  integer :baz
                end
              end
            end
          end

          entity :anything do
            any_of [
              null,
              string,
              object {
                string :one
                string :two
              }
            ]
          end
        end
      end
    end.new.example.schema
  end

  let(:other) do
    Class.new do
      include JSON::SchemaBuilder

      def example
        object do
          integer :a2

          object :b do
            integer :d
          end

          array :array do
            items do
              object do
                object :bar do
                  integer :qux
                end
              end
            end
          end

          entity :anything do
            any_of [
              null,
              object {
                string :two
                string :three
              }
            ]
          end
        end
      end
    end.new.example.schema
  end

  let(:merged) do
    {
      "type" => :object,
      "properties" => {
        "a" => {
          "type" => "integer"
        },
        "a2" => {
          "type" => "integer"
        },
        "b" => {
          "type" => "object",
          "properties" => {
            "c" => {
              "type" => "integer"
            },
            "d" => {
              "type" => "integer"
            }
          }
        },
        "array" => {
          "type" => "array",
          "items" => {
            "type" => "object",
            "properties" => {
              "foo" => {
                "type" => "integer",
              },
              "bar" => {
                "type" => "object",
                "properties" => {
                  "baz" => {
                    "type" => "integer"
                  },
                  "qux" => {
                    "type" => "integer"
                  }
                }
              }
            }
          }
        },
        "anything" => {
          "anyOf" => [
            {
              "type" => "null"
            },
            {
              "type" => "string"
            },
            {
              "type" => "object",
              "properties" => {
                "one" => {
                  "type" => "string"
                },
                "two" => {
                  "type" => "string"
                },
                "three" => {
                  "type" => "string"
                }
              }
            }
          ]
        }
      }
    }
  end

  its(:data){ is_expected.to be_a(HashWithIndifferentAccess) }

  describe '#merge' do
    it 'should deep merge' do
      merged_schema = schema.merge other
      expect(merged_schema).to be_a described_class
      expect(merged_schema.data).to eql merged
    end

    it 'should not modify the source schema' do
      expect{ schema.merge other }.to_not change{ schema.data }
    end

    it 'should not modify the merging schema' do
      expect{ schema.merge other }.to_not change{ other.data }
    end
  end

  describe '#merge!' do
    it 'should deep merge in place' do
      merged_schema = schema.merge! other
      expect(merged_schema).to be_a described_class
      expect(merged_schema.data).to eql merged
    end

    it 'should not modify the merging schema' do
      expect{ schema.merge! other }.to_not change { other.data }
    end
  end

  %w(validate validate! fully_validate).each do |validator|
    describe "##{ validator }" do
      it "should #{ validator }" do
        expect(JSON::Validator).to receive(validator)
          .with schema.as_json, { }, opts: true
        schema.send validator, { }, opts: true
      end
    end
  end

  describe "#fragments" do
    context "with an unmerged schema" do
      subject(:fragments) { schema.fragments }
      its(:keys) do
        is_expected.to match_array %w(
          #/
          #/a
          #/b
          #/b/c
          #/array
          #/array/foo
          #/array/bar
          #/array/bar/baz
          #/anything
          #/anything/one
          #/anything/two
        )
      end

      it "stores the schema by fragment" do
        expect(fragments["#/"].first.as_json).to eq schema.as_json
      end

      it "structures the fragments correctly" do
        expect(fragments.values.flatten).to all be_a JSON::SchemaBuilder::Entity
        expect(fragments["#/"].length).to eq 1
        expect(fragments["#/"].length).to eq 1
        expect(fragments["#/a"].length).to eq 1
        expect(fragments["#/b"].length).to eq 1
        expect(fragments["#/b/c"].length).to eq 1
        expect(fragments["#/array"].length).to eq 3
        expect(fragments["#/array/foo"].length).to eq 1
        expect(fragments["#/array/bar"].length).to eq 1
        expect(fragments["#/array/bar/baz"].length).to eq 1
        expect(fragments["#/anything"].length).to eq 4
        expect(fragments["#/anything/one"].length).to eq 1
        expect(fragments["#/anything/two"].length).to eq 1
      end
    end

    context "with a merged schema" do
      subject(:fragments) { schema.merge(other).fragments }
      its(:keys) do
        is_expected.to match_array %w(
          #/
          #/a
          #/a2
          #/b
          #/b/c
          #/b/d
          #/array
          #/array/foo
          #/array/bar
          #/array/bar/baz
          #/array/bar/qux
          #/anything
          #/anything/one
          #/anything/two
          #/anything/three
        )
      end

      it "stores the schema by fragment" do
        expect(fragments["#/"].first.as_json).to eq schema.as_json
      end

      it "structures the fragments correctly" do
        expect(fragments.values.flatten).to all be_a JSON::SchemaBuilder::Entity
        expect(fragments["#/"].length).to eq 2
        expect(fragments["#/a"].length).to eq 1
        expect(fragments["#/a2"].length).to eq 1
        expect(fragments["#/b"].length).to eq 2
        expect(fragments["#/b/c"].length).to eq 1
        expect(fragments["#/b/d"].length).to eq 1
        expect(fragments["#/array"].length).to eq 6
        expect(fragments["#/array/foo"].length).to eq 1
        expect(fragments["#/array/bar"].length).to eq 2
        expect(fragments["#/array/bar/baz"].length).to eq 1
        expect(fragments["#/array/bar/qux"].length).to eq 1
        expect(fragments["#/anything"].length).to eq 7
        expect(fragments["#/anything/one"].length).to eq 1
        expect(fragments["#/anything/two"].length).to eq 2
        expect(fragments["#/anything/three"].length).to eq 1
      end
    end
  end
end
