require_relative 'container_entity'

module JSON
  module SchemaBuilder
    class Object < ContainerEntity
      register :object
      attribute :required
      attribute :min_properties
      attribute :max_properties
      attribute :properties
      attribute :additional_properties
      attribute :pattern_properties

      def initialize(name, opts = { }, &block)
        self.properties = { }
        super
        children.each do |child|
          self.properties[child.name] = child.as_json
        end
      end
    end
  end
end
