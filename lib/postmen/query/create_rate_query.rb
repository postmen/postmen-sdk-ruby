class Postmen
  # This class holds all the logic behind preparing query for
  # creating a Rate. It does type convertion, removes empty values and so on.
  class CreateRateQuery < Dry::Struct
    constructor_type :strict_with_defaults

    # async	boolean	enable async mode or not (set to false if not provided)
    # is_document	boolean	If the shipment is document type. (set to false if not provided)

    attribute :shipment, Shipment
    attribute :shipper_accounts, Types::Array.member(Types::Reference)

    # Converts query object to hash
    # @return [Hash]
    def to_query
      {
        json: query
      }
    end

    private

    def query
      to_hash.reject { |_k, v| v.nil? }
    end
  end
end
