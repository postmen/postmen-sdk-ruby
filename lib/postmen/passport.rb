class Postmen
  # Passport object
  #
  # @see https://docs.postmen.com/api.html#passport
  class Passport < Dry::Struct
    # Expected format for dates
    # example value: 2017-01-19
    DATE_FORMAT = '%F'.freeze

    attribute :number, Types::String
    attribute :issue_date, Types::Date

    # Formats issue date to expected format
    # @return [String]
    def issue_date
      super.strftime(DATE_FORMAT)
    end
  end
end
