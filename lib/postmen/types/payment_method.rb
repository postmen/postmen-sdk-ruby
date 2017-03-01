class Postmen
  module Types
    # Payment method.
    #
    # @see https://docs.postmen.com/api.html#payment-method---account API Documentation
    class PaymentMethod < Dry::Struct
      attribute :type, Types::String
      attribute :account_number, Types::String
      attribute :postal_code, Types::String
      attribute :country, Country
    end
  end
end
