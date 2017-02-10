class Postmen
  class Label < Dry::Struct
    attribute :id, Types::UUID
    attribute :status, Types::String
    attribute :tracking_numbers, Types::Array.member(Types::String)
    attribute :files, Types::Strict::Nil | Types::Array.member(Types::Hash)
    attribute :rate, Types::Strict::Nil | Types::Hash

    def self.all(options = {})
      LabelCollection.all(options)
    end

    def self.find(id)
      LabelCollection.find(id)
    end
  end
end
