class Postmen
  module Types
    # Money object
    # @see https://docs.postmen.com/api.html#money API Documentation
    class Money < Dry::Struct
      attribute :amount, Types::Float
      attribute :currency, Types::String
    end
  end
end
