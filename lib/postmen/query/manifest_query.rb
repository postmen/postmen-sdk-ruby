# shipper_account_id	string	Shipper account ID
# status	string	Manifest status Accepts: manifesting,manifested,failed.
# limit	string	Number of records per page
# created_at_min	string	Start date and time of the record created (default: 24hrs ago)
# created_at_max	string	End date and time of the record created (default: NOW())
# next_token	string	Next token

class Postmen
  # This class holds all the logic behind querying for a single Manifest.
  # @see ManifestCollection.find Usage
  class ManifestQuery < Dry::Struct
    # Expected format for dates
    # example value: 2017-02-08T10:17:04+01:00
    DATE_FORMAT = '%FT%T%:z'.freeze

    constructor_type :schema

    attribute :shipper_account_id, Types::String.optional
    attribute :status, Types::Strict::Nil | Types::ManifestStatuses
    attribute :limit, Types::String.optional
    attribute :created_at_min, Types::DateTime.maybe
    attribute :created_at_max, Types::DateTime.maybe
    attribute :next_token, Types::String.optional

    # Converts query object to hash
    # @return [Hash]
    def to_query
      {
        params: query
      }
    end

    private

    def format_date(date)
      date.fmap { |d| d.strftime(DATE_FORMAT) }.value
    end

    def query
      {
        shipper_account_id: shipper_account_id,
        status: status,
        limit: limit,
        created_at_min: format_date(created_at_min),
        created_at_max: format_date(created_at_max),
        next_token: next_token
      }.reject { |_k, v| v.nil? }
    end
  end
end
