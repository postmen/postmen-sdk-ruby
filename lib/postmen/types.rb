# Load '.maybe' extension for DRY::Types
Dry::Types.load_extensions(:maybe)

class Postmen
  # This module holds all definitions of simple types used in the API
  module Types
    include Dry::Types.module

    # Passport object
    #
    # @see https://docs.postmen.com/api.html#passport API Documentation
    Passport = Types::Hash

    # Address object
    #
    # @see https://docs.postmen.com/api.html#address API Documentation
    Address = Types::Hash

    # UUID Type
    #
    # @see https://en.wikipedia.org/wiki/Universally_unique_identifier Definition
    UUID = Types::Strict::String.constrained(
      format: /^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i
    )

    # Possible statuses for labels.
    Statuses = Types::String.enum(
      'creating',
      'created',
      'cancelling',
      'cancelled',
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

    # Name of the country
    Country = Types::String

    # Shipment object reference
    # @see https://docs.postmen.com/api.html#reference API Documentation
    Reference = Types::Hash.schema(id: Types::UUID)

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

    # Payment method.
    #
    # @see https://docs.postmen.com/api.html#payment-method---account API Documentation
    PaymentMethod = Types::Hash.schema(type: Types::String,
                                       account_number: Types::String,
                                       postal_code: Types::String,
                                       country: Country)
    # Customs billing
    #
    # @see https://docs.postmen.com/api.html#customs-billing API Documentation
    CustomsBilling = Types::Hash.schema(paid_by: Types::PaidBy,
                                        method: Types::PaymentMethod)
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

    # Invoice object
    #
    # @see https://docs.postmen.com/api.html#a-invoice-file-object
    Invoice = Types::Hash

    # Billing object
    #
    # @see https://docs.postmen.com/api.html#billing API Documentation
    Billing = Types::Hash

    # FTR Exemption - used in NoEEI object
    # @see NoEEI
    # @see https://docs.postmen.com/api.html#no_eei API Documentation
    FtrExemption = Types::String.enum(
      'noeei_30_37_a',
      'noeei_30_37_h',
      'noeei_30_36'
    )

    # EEI type - AES - used in Customs object
    # @see Customs
    # @see https://docs.postmen.com/api.html#aes API Documentation
    AES = Types::Hash.schema(type: Types::String,
                             itn_number: Types::String)

    # EEI type - no_eei - used in Customs object
    # @see Customs
    # @see https://docs.postmen.com/api.html#no_eei API Documentation
    NoEEI = Types::Hash.schema(type: Types::String,
                               ftr_exemption: Types::FtrExemption)

    # Customs object
    # @see https://docs.postmen.com/api.html#customs API Documentation
    Customs = Types::Hash.schema(purpose: Types::CustomsPurpose,
                                 terms_of_trade: Types::TermsOfTrade,
                                 eei: Types::AES | Types::NoEEI,
                                 billing: Types::CustomsBilling,
                                 importer_address: Address,
                                 passport: Passport)

    # Money object
    # @see https://docs.postmen.com/api.html#money API Documentation
    Money = Types::Hash.schema(amount: Types::Float,
                               currency: Types::String)
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

    # Weight
    # @see https://docs.postmen.com/api.html#weight API Documentation
    Weight = Types::Hash.schema(unit: Types::WeightUnit, value: Types::Float)

    # Dimension
    # @see https://docs.postmen.com/api.html#dimension API Documentation
    Dimension = Types::Hash.schema(width: Types::Float,
                                   height: Types::Float,
                                   depth: Types::Float,
                                   unit: Types::DimensionUnit)

    # Item - element of shippment
    # @see https://docs.postmen.com/api.html#item API Documentation
    Item = Types::Hash.schema(description: Types::String,
                              quantity: Types::Int,
                              price: Types::Money,
                              weight: Types::Weight,
                              item_id: Types::String,
                              origin_country: Types::Country,
                              sku: Types::String,
                              hs_code: Types::String)
  end
end
