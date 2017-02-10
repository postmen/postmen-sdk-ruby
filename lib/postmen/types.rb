Dry::Types.load_extensions(:maybe)

class Postmen
  module Types
    include Dry::Types.module

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

    Reference = Types::Hash.schema(id: Types::UUID)
    Shipment = Types::Hash
    PaperSize = Types::String.enum(
      '4x4',
      '4x6',
      '4x6.75',
      '4x8',
      '6x4',
      'a4',
      'default'
    )

    Invoice = Types::Hash
    Billing = Types::Hash
    Customs = Types::Hash
  end
end
