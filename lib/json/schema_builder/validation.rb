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
        customize_errors = opts.delete(:customize_errors)
        opts[:errors_as_objects] = true if customize_errors
        validation_errors = JSON::Validator.send validator, as_json, data, opts
        customize_errors ? _customize_errors(validation_errors) : validation_errors
      end

      def _customize_errors(error_objects)
        _flatten_errors(error_objects).each do |error|
          entities = _entities_handling(error)
          entities.each do |entity|
            handler = entity.error
            case handler
            when ::Proc
              handler.call(entities, error)
            when ::String
              error[:message] = entity.error
            end
          end
        end
      end

      def _flatten_errors(error_objects)
        error_objects.map do |error_object|
          sub_errors = error_object.delete(:errors) || []
          sub_errors = sub_errors.values.flatten if sub_errors.is_a?(Hash)
          [error_object, _flatten_errors(sub_errors)]
        end.flatten
      end

      def _entities_handling(error)
        entities = Array(fragments[error[:fragment]]).select(&:error)
        if error[:failed_attribute] == "Required"
          property = error[:message].match(/required property of '([^']+?)'/)[1]
          property_fragment = "#{error[:fragment]}/#{property}".gsub(%r(//), "/")
          entities |= Array(fragments[property_fragment]).select(&:error)
        end
        entities
      end
    end
  end
end
