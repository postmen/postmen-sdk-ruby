class Postmen
  # This class holds all the logic behind querying for a single Rate.
  # @see RateCollection.find Usage
  class RateQuery < Dry::Struct
    # Expected format for dates
    # example value: 2017-02-08T10:17:04+01:00
    DATE_FORMAT = '%FT%T%:z'.freeze

    constructor_type :schema

    attribute :status, Types::Strict::Nil | Types::RateStatuses
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
        status: status,
        limit: limit,
        created_at_min: format_date(created_at_min),
        created_at_max: format_date(created_at_max),
        next_token: next_token
      }.reject { |_k, v| v.nil? }
    end
  end
end
