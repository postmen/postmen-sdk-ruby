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
  end
end
