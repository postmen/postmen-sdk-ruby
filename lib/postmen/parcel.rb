class Postmen
  # Parcel object
  #
  # @see https://docs.postmen.com/api.html#parcel API Documentation
  class Parcel < Dry::Struct
    attribute :description, Types::String.optional
    attribute :box_type, Types::String
    attribute :weight, Types::Strict::Nil | Types::Weight
    attribute :dimension, Types::Dimension
    attribute :items, Types::Array.member(Types::Item)
  end
end
