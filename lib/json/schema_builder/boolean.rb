require_relative 'entity'

module JSON
  module SchemaBuilder
    class Boolean < Entity
      register :boolean
    end
  end
end
