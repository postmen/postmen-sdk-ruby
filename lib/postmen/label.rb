class Postmen
  class Label < Dry::Struct
    attribute :id, Types::String # TODO: implement UUID type
    attribute :status, Types::String
    attribute :tracking_numbers, Types::Array.member(Types::String)
    attribute :files, Types::Array.member(Types::Hash)
    attribute :rate, Types::Hash

    def self.all
      LabelCollection.all
    end
  end
end
