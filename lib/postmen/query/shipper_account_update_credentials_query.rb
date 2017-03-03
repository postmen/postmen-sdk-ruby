class Postmen
  # This class holds all the logic behind
  # updating credentials for a ShipperAccount details
  # @see ShipperAccount.update_credentials Usage
  class ShipperAccountUpdateCredentialsQuery < Dry::Types::Hash
    # Converts query object to hash
    # @return [Hash]
    def to_query
      {
        json: query
      }
    end

    private

    def query
      primitive.reject { |_k, v| v.nil? }
    end
  end
end
