class Postmen
  # This class holds all the logic behind preparing query for
  # creating a Manifest. It does type convertion, removes empty values and so on.
  class CreateManifestQuery < Dry::Struct
    constructor_type :strict_with_defaults

    attribute :shipper_account, Types::Reference

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
