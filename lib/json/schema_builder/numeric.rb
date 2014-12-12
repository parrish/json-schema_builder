require_relative 'entity'

module JSON
  module SchemaBuilder
    class Numeric < Entity
      attribute :multiple_of
      attribute :minimum
      attribute :maximum
      attribute :exclusive_minimum
      attribute :exclusive_maximum
    end
  end
end
