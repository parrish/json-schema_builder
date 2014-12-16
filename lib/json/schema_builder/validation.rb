require 'json-schema'

module JSON
  module SchemaBuilder
    module Validation
      def validate(data, opts = { })
        _validate :validate, data, opts
      end

      def validate!(data, opts = { })
        _validate :validate!, data, opts
      end

      def fully_validate(data, opts = { })
        _validate :fully_validate, data, opts
      end

      protected

      def _validate(validator, data, opts)
        opts.reverse_merge! options if options
        JSON::Validator.send validator, as_json, data, opts
      end
    end
  end
end
