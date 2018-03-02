module Examples
  class BuilderReopening < BuilderInitialization
    def example
      obj = super
      obj.extend(:settings) do
        string :phone_number
      end
      ids = obj.array :ids
      ids.items type: :string
      obj
    end
  end
end
