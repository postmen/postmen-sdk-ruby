class Postmen
  # This class holds all the logic behind updating a ShipperAccount details
  # @see ShipperAccount.update Usage
  class ShipperAccountUpdateQuery < Dry::Struct
    constructor_type :schema

    attribute :subject, ShipperAccount
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
        description: description || subject.description,
        timezone: timezone || subject.timezone,
        address: (address || subject.address).to_h
      }.reject { |_k, v| v.nil? }
    end
  end
end
