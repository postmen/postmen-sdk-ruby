class Postmen
  module Types
    # EEI type - AES - used in Customs object
    # @see Customs
    # @see https://docs.postmen.com/api.html#aes API Documentation
    class AES < Dry::Struct
      attribute :type, Types::String
      attribute :itn_number, Types::String
    end
  end
end
