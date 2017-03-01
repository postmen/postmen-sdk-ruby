class Postmen
  module Types
    # Shipper account object
    # (brief information for rate and manifest responses)
    # @see https://docs.postmen.com/api.html#shipper-account-information API Documentation
    class ShipperAccount < Dry::Struct
      attribute :id, Types::UUID
      attribute :slug, Types::String
      attribute :description, Types::String
    end
  end
end
