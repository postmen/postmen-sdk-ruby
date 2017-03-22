class Postmen
  module Types
    # Manifesting Label
    # @see https://docs.postmen.com/api.html#a-manifesting-label-object API Documentation
    class ManifestingLabel < Dry::Struct
      constructor_type :schema

      attribute :id, Types::UUID
      attribute :manifested, Types::Bool
    end
  end
end
