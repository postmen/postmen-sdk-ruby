class Postmen
  # Rate object
  # It encapsulates Rate record objects
  # @see RateObject
  # @see https://docs.postmen.com/api.html#rates API documentation
  class Rate < Dry::Struct
    attribute :id, Types::UUID
    attribute :status, Types::RateStatuses
    attribute :rates, Types::Array.member(RateObject)

    # Returns all rates
    #
    # @see RateCollection#all
    # @return [RateCollection] Collection of Rates
    def self.all(options = {})
      RateCollection.all(options)
    end

    # Fetches single rate
    #
    # @see RateCollection#find
    # @return [Rate]
    def self.find(id)
      RateCollection.find(id)
    end

    # Creates an instance of Rate
    #
    # @see RateCollection#create
    # @return [Rate]
    def self.create(params)
      RateCollection.create(params)
    end
  end
end
