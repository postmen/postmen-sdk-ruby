class Postmen
  module Types
    # Detailed Charges object
    # @see https://docs.postmen.com/api.html#detailed-charges API Documentation
    class DetailedCharges < Dry::Struct
      attribute :type, Types::String
      attribute :charge, Types::Money
    end
  end
end
