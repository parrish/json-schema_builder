module JSON
  module SchemaBuilder
    module Attribute
      extend ActiveSupport::Concern

      module ClassMethods
        def attribute(name, as: nil, array: false)
          attr = as || snakeize(name)
          define_method name do |*values|
            if array
              _array_attr attr, values.flatten
            else
              _attr attr, values.first
            end
          end
          alias_method "#{ name }=", name
        end

        protected

        def snakeize(str)
          str.to_s.underscore.gsub(/_(\w)/){ $1.upcase }
        end
      end

      protected

      def _array_attr(attr, values)
        if values.empty?
          self.schema[attr]
        else
          self.schema[attr] = values
        end
      end

      def _attr(attr, value)
        if value.nil?
          self.schema[attr]
        else
          self.schema[attr] = value
        end
      end
    end
  end
end
