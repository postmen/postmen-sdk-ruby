class Postmen
  module Types
    # Customs object
    # @see https://docs.postmen.com/api.html#customs API Documentation
    class Customs < Dry::Struct
      constructor_type :schema

      attribute :purpose, Types::CustomsPurpose
      attribute :terms_of_trade, Types::TermsOfTrade
      attribute :eei, Types::AES | Types::NoEEI
      attribute :billing, Types::CustomsBilling
      attribute :importer_address, Address
      attribute :passport, Passport
    end
  end
end
