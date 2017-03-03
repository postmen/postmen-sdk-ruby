class Postmen
  # This class holds all the logic behind updating a ShipperAccount details
  # @see ShipperAccount.update Usage
  class ShipperAccountUpdateQuery < Dry::Struct
    constructor_type :schema

    attribute :description, Types::String
    attribute :timezone, Types::Timezone
    attribute :address, Types::Address

    # Converts query object to hash
    # @return [Hash]
    def to_query
      {
        json: query
      }
    end

    private

    def query
      {
        description: description,
        timezone: timezone,
        address: address
      }.reject { |_k, v| v.nil? }
    end
  end
end
