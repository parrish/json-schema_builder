require_relative 'container_entity'

module JSON
  module SchemaBuilder
    class Object < ContainerEntity
      register :object
    end
  end
end
