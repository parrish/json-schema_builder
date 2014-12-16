require 'json-schema'

module JSON
  module SchemaBuilder
    module Validation
      def validate(data, opts = { })
        JSON::Validator.validate as_json, data, opts
      end

      def validate!(data, opts = { })
        JSON::Validator.validate! as_json, data, opts
      end

      def fully_validate(data, opts = { })
        JSON::Validator.fully_validate as_json, data, opts
      end
    end
  end
end
