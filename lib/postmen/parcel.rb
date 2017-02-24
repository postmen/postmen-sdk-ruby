class Postmen
  # Parcel object
  #
  # @see https://docs.postmen.com/api.html#parcel API Documentation
  class Parcel < Dry::Struct
    attribute :description, Types::String
    attribute :box_type, Types::String
    attribute :dimension, Types::Dimension
    attribute :items, Types::Array.member(Types::Item)
    attribute :weight, Types::Weight
  end
end
