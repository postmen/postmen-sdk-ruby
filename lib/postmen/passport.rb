class Postmen
  class Passport < Dry::Struct
    DATE_FORMAT = '%F'.freeze

    attribute :number, Types::String
    attribute :issue_date, Types::Date

    def issue_date
      super.strftime(DATE_FORMAT)
    end
  end
end
