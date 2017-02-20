Dry::Types.load_extensions(:maybe)

class Postmen
  module Types
    include Dry::Types.module
    Passport = Types::Hash
    Address = Types::Hash
    UUID = Types::Strict::String.constrained(
      format: /^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i
    )

    Statuses = Types::String.enum(
      'creating',
      'created',
      'cancelling',
      'cancelled',
      'manifesting',
      'manifested',
      'failed'
    )

    AddressType = Types::String.enum(
      'business',
      'residential'
    )

    Country = Types::String
    Reference = Types::Hash.schema(id: Types::UUID)
    PaperSize = Types::String.enum(
      '4x4',
      '4x6',
      '4x6.75',
      '4x8',
      '6x4',
      'a4',
      'default'
    )

    CustomsPurpose = Types::String.enum(
      'gift',
      'merchandise',
      'sample',
      'return',
      'repair'
    )
    PaidBy = Types::String.enum(
      'shipper',
      'recipient',
      'third_party'
    )

    PaymentMethod = Types::Hash.schema(type: Types::String,
                                       account_number: Types::String,
                                       postal_code: Types::String,
                                       country: Country)

    CustomsBilling = Types::Hash.schema(paid_by: Types::PaidBy,
                                        method: Types::PaymentMethod)

    TermsOfTrade = Types::String.enum(
      'dat',
      'ddu',
      'ddp',
      'dap'
    )

    Invoice = Types::Hash
    Billing = Types::Hash

    FtrExemption = Types::String.enum(
      'noeei_30_37_a',
      'noeei_30_37_h',
      'noeei_30_36'
    )

    AES = Types::Hash.schema(type: Types::String,
                             itn_number: Types::String)

    NoEEI = Types::Hash.schema(type: Types::String,
                               ftr_exemption: Types::FtrExemption)
    Customs = Types::Hash.schema(purpose: Types::CustomsPurpose,
                                 terms_of_trade: Types::TermsOfTrade,
                                 eei: Types::AES | Types::NoEEI,
                                 billing: Types::CustomsBilling,
                                 importer_address: Address,
                                 passport: Passport)

    Money = Types::Hash.schema(amount: Types::Float,
                               currency: Types::String)

    WeightUnit = Types::String.enum(
      'lb',
      'kg',
      'oz',
      'g'
    )

    DimensionUnit = Types::String.enum(
      'cm',
      'in',
      'mm',
      'm',
      'ft',
      'yd'
    )

    Weight = Types::Hash.schema(unit: Types::WeightUnit, value: Types::Float)
    Dimension = Types::Hash.schema(width: Types::Float,
                                   height: Types::Float,
                                   depth: Types::Float,
                                   unit: Types::DimensionUnit)

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
