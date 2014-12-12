require_relative 'numeric'

module JSON
  module SchemaBuilder
    class Integer < Numeric
      register :integer
    end
  end
end
