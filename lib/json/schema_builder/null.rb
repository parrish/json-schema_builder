require_relative 'entity'

module JSON
  module SchemaBuilder
    class Null < Entity
      register :null
    end
  end
end
