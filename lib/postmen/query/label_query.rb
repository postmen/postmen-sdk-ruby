class Postmen
  class LabelQuery < Dry::Struct
    DATE_FORMAT = '%FT%T%:z'.freeze

    constructor_type :schema

    attribute :shipper_account_id, Types::String.optional
    attribute :status, Types::Strict::Nil | Types::Statuses
    attribute :limit, Types::String.optional
    attribute :created_at_min, Types::DateTime.maybe
    attribute :created_at_max, Types::DateTime.maybe
    attribute :tracking_numbers, Types::String.maybe
    attribute :next_token, Types::String.optional

    def to_query
      {
        params: query
      }
    end

    private

    def format_date(date)
      date.fmap { |d| d.strftime(DATE_FORMAT) }.value
    end

    def formatted_tracking_numbers
      tracking_numbers.fmap{|numbers| Array(numbers).join(',') }.value
    end

    def query
      {
        shipper_account_id: shipper_account_id,
        status: status,
        limit: limit,
        created_at_min: format_date(created_at_min),
        created_at_max: format_date(created_at_max),
        tracking_numbers: formatted_tracking_numbers,
        next_token: next_token
      }.reject { |_k, v| v.nil? }
    end
  end
end
