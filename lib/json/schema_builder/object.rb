require_relative 'entity'

module JSON
  module SchemaBuilder
    class Object < Entity
      register :object
      attribute :required
      attribute :min_properties
      attribute :max_properties
      attribute :properties
      attribute :additional_properties
      attribute :pattern_properties

      def initialize_children
        self.properties = { }

        children.select(&:name).each do |child|
          case child.name
          when Regexp
            self.pattern_properties ||= { }
            self.pattern_properties[child.name.source] = child.as_json
          else
            self.properties[child.name] = child.as_json
          end
        end
        build_any_of if @nullable
      end

      def extract_types
        initialize_children
        super
      end

      def reinitialize
        return unless initialized?
        extract_types
      end

      def required(*values)
        case values
        when []
          @schema[:required]
        when [true]
          @parent.required ||= []
          @parent.required << @name
        else
          @schema[:required] = values.flatten
        end
      end
      alias_method :required=, :required
    end
  end
end
