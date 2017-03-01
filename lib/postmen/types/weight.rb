class Postmen
  module Types
    # Weight
    # @see https://docs.postmen.com/api.html#weight API Documentation
    class Weight < Dry::Struct
      attribute :unit, Types::WeightUnit
      attribute :value, Types::Float
    end
  end
end
