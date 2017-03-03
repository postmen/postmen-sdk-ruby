class Postmen
  # This class holds all the logic behind preparing query for
  # creating a ShipperAccount. It does type convertion, removes empty values and so on.
  # @see ShipperAccountCollection#create Usage
  class CreateShipperAccountQuery < Dry::Struct
    constructor_type :schema

    attribute :slug, Types::String
    attribute :description, Types::String
    attribute :address, Types::Address
    attribute :timezone, Types::Timezone
    attribute :credentials, Types::Hash

    # Converts query object to hash
    # @return [Hash]
    def to_query
      {
        params: query
      }
    end
  end
end
