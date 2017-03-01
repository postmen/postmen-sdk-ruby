class Postmen
  module Types
    # Dimension
    # @see https://docs.postmen.com/api.html#dimension API Documentation
    class Dimension < Dry::Struct
      attribute :width, Types::Float
      attribute :height, Types::Float
      attribute :depth, Types::Float
      attribute :unit, Types::DimensionUnit
    end
  end
end
