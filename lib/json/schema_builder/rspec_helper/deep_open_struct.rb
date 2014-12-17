module JSON
  module SchemaBuilder
    module RSpecHelper
      class DeepOpenStruct < OpenStruct
        def initialize(hash = { })
          @table = { }
          hash.each_pair do |key, value|
            key = key.to_sym
            @table[key] = _transform value
            new_ostruct_member key
          end
        end

        def ==(other)
          to_h == other.to_h
        end
        alias_method :eql?, :==

        def inspect
          to_h.inspect
        end

        private

        def _transform(object)
          case object
          when Hash
            DeepOpenStruct.new object
          when Array
            object.map{ |item| _transform item }
          else
            object
          end
        end
      end
    end
  end
end
