class Postmen
  # Shipment object
  #
  # @see https://docs.postmen.com/api.html#shipment API documentation
  class Shipment < Dry::Struct
    constructor_type :strict_with_defaults

    attribute :ship_from, Address
    attribute :ship_to, Address
    attribute :parcels, Types::Array.member(Parcel)

    # Converts object to hash
    # @return [Hash]
    def to_hash
      super.reject { |_k, v| v.nil? }
    end
  end
end
