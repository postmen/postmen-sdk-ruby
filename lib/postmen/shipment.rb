class Postmen
  class Shipment < Dry::Struct
    constructor_type :strict_with_defaults

    attribute :ship_from, Address
    attribute :ship_to, Address
    attribute :parcels, Types::Array.member(Parcel)

    def to_hash
      super.reject { |_k, v| v.nil? }
    end
  end
end
