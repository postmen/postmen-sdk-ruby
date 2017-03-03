# Load '.maybe' extension for DRY::Types
Dry::Types.load_extensions(:maybe)

class Postmen
  # This module holds all definitions of simple types used in the API
  module Types
    include Dry::Types.module

    # Possible statuses for Rates.
    RateStatuses = Types::String.enum(
      'calculating',
      'calculated',
      'failed'
    )

    # Possible statuses for Labels.
    LabelStatuses = Types::String.enum(
      'creating',
      'created',
      'cancelling',
      'cancelled',
      'manifesting',
      'manifested',
      'failed'
    )

    # Possible statuses for Manifest
    ManifestStatuses = Types::String.enum(
      'manifesting',
      'manifested',
      'failed'
    )

    # Type of the address
    # @see Address
    AddressType = Types::String.enum(
      'business',
      'residential'
    )

    # List of possible Shipper Account Types
    ShipperAccountTypes = Types::String.enum(
      'user',
      'user_prepaid'
    )

    # Timezone (use IANA name)
    Timezone = Types::String

    # Name of the country
    Country = Types::String

    # Paper size
    PaperSize = Types::String.enum(
      '4x4',
      '4x6',
      '4x6.75',
      '4x8',
      '6x4',
      'a4',
      'default'
    )

    # Purpose used in customs object
    #
    # @see https://docs.postmen.com/api.html#customs API Documentation
    CustomsPurpose = Types::String.enum(
      'gift',
      'merchandise',
      'sample',
      'return',
      'repair'
    )

    # Paid by, used in customs billing.
    #
    # @see CustomsBilling
    # @see https://docs.postmen.com/api.html#customs-billing API Documentation
    PaidBy = Types::String.enum(
      'shipper',
      'recipient',
      'third_party'
    )

    # Terms of trade - used in customs object
    #
    # @see Customs
    # @see https://docs.postmen.com/api.html#customs API Documentation
    TermsOfTrade = Types::String.enum(
      'dat',
      'ddu',
      'ddp',
      'dap'
    )

    # FTR Exemption - used in NoEEI object
    # @see NoEEI
    # @see https://docs.postmen.com/api.html#no_eei API Documentation
    FtrExemption = Types::String.enum(
      'noeei_30_37_a',
      'noeei_30_37_h',
      'noeei_30_36'
    )

    # Unit of weight - used in Weight object
    # @see Weight
    WeightUnit = Types::String.enum(
      'lb',
      'kg',
      'oz',
      'g'
    )

    # Unit for dimension - used in Dimension object
    # @see Dimension
    DimensionUnit = Types::String.enum(
      'cm',
      'in',
      'mm',
      'm',
      'ft',
      'yd'
    )
  end
end
require_relative 'types/address'
require_relative 'types/invoice'
require_relative 'types/weight'
require_relative 'types/passport'
require_relative 'types/uuid'
require_relative 'types/reference'
require_relative 'types/payment_method'
require_relative 'types/brief_shipper_account'
require_relative 'types/dimension'
require_relative 'types/billing'
require_relative 'types/money'
require_relative 'types/item'
require_relative 'types/customs_billing'
require_relative 'types/aes'
require_relative 'types/no_eei'
require_relative 'types/customs'
require_relative 'types/detailed_charges'
