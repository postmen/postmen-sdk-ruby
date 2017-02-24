class Postmen
  # Label object
  #
  # @see https://docs.postmen.com/api.html#labels API documentation
  class Label < Dry::Struct
    attribute :id, Types::UUID
    attribute :status, Types::String
    attribute :tracking_numbers, Types::Array.member(Types::String)
    attribute :files, Types::Strict::Nil | Types::Array.member(Types::Hash)
    attribute :rate, Types::Strict::Nil | Types::Hash

    # Returns all labels
    #
    # @see LabelCollection#all
    # @return [LabelCollection] Collection of Labels
    def self.all(options = {})
      LabelCollection.all(options)
    end

    # Fetches single label
    #
    # @see LabelCollection#find
    # @return [Label]
    def self.find(id)
      LabelCollection.find(id)
    end

    # Creates an instance of Label
    #
    # @see LabelCollection#create
    # @return [Label]
    def self.create(params)
      LabelCollection.create(params)
    end
  end
end
