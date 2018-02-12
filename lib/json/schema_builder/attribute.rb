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

      def _array_attr(attr, values = [])
        if values.empty?
          self.schema[attr] || []
        else
          self.schema[attr] ||= []
          _rename_array_values!(values)
          self.schema[attr] += values
          self.schema[attr].uniq!
          self.schema[attr]
        end
      end

      def _attr(attr, value)
        if value.nil?
          self.schema[attr]
        else
          self.schema[attr] = value
        end
      end

      def _rename_array_values!(values)
        values.each do |value|
          if value.class < Entity && value.name
            value.name = nil
            value.reset_fragment
          end
        end
      end
    end
  end
end
