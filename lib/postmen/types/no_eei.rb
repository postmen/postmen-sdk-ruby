class Postmen
  module Types
    # EEI type - no_eei - used in Customs object
    # @see Customs
    # @see https://docs.postmen.com/api.html#no_eei API Documentation
    class NoEEI < Dry::Struct
      attribute :type, Types::String
      attribute :ftr_exemption, Types::FtrExemption
    end
  end
end
