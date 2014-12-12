require_relative 'numeric'

module JSON
  module SchemaBuilder
    class Number < Numeric
      register :number
    end
  end
end
