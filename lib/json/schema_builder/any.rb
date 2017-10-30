require_relative 'entity'

module JSON
  module SchemaBuilder
    class Any < Entity
      register :any
    end
  end
end
