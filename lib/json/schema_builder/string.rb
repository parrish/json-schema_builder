require_relative 'entity'

module JSON
  module SchemaBuilder
    class String < Entity
      register :string
      attribute :min_length
      attribute :max_length
      attribute :pattern
    end
  end
end
