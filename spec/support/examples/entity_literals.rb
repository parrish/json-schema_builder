module Examples
  class EntityLiterals
    include JSON::SchemaBuilder

    def example
      object do
        entity 'one', required: true do
          enum [:string, :null]
        end

        entity 'two' do
          all_of positive_int, string
        end

        entity 'three' do
          any_of [positive_int, null]
        end

        entity 'four' do
          not_a null
        end

        entity 'five' do
          one_of string, number
        end
      end
    end

    def bad_example
      object do
        entity 'bad' do
          not_a undefined_method
        end
      end
    end

    def positive_int
      integer minimum: 1
    end
  end
end
