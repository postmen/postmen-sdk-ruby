class Postmen
  module Types
    # Object reference
    # @see https://docs.postmen.com/api.html#reference API Documentation
    class Reference < Dry::Struct
      attribute :id, Types::UUID
    end
  end
end
