class Postmen
  # This class holds all the logic behind querying for a single ShipperAccount.
  # @see ShipperAccountCollection.find Usage
  class ShipperAccountQuery < Dry::Struct
    constructor_type :schema

    attribute :slug, Types::String
    attribute :limit, Types::Int
    attribute :next_token, Types::String

    # Converts query object to hash
    # @return [Hash]
    def to_query
      {
        params: query
      }
    end

    private

    def query
      {
        slug: slug,
        limit: limit,
        next_token: next_token
      }.reject { |_k, v| v.nil? }
    end
  end
end
