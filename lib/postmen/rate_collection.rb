require 'byebug'
class Postmen
  # This class wraps the array of Rate models
  class RateCollection
    include CollectionProxy

    model Rate
    key :rates

    # Fetch all rates.
    #
    # @param options [Hash] Options for the query.
    # @see https://docs.postmen.com/api.html#rates-list-all-rates API documentation
    # @example
    #   .all # Returns all rates, default query.
    #   .all(status: :failed) # Returns only failed rates
    def self.all(options = {})
      new(Connection.new.get('/rates', RateQuery.new(options).to_query).parsed_response)
    end

    # Fetch single rate
    #
    # @param id [UUID] Rate UUID
    # @see https://docs.postmen.com/api.html#rates-calculate-rates API documentation
    # @return [Rate]
    # @raise ResourceNotFound if Rate with given id was not found
    def self.find(id)
      get(Connection.new.get("/rates/#{id}").parsed_response)
    end

    # Creates a Rate
    #
    # @param params [Hash] Rate params
    # @see https://docs.postmen.com/api.html#labels-create-a-label API documentation
    # @return [Rate]
    def self.create(params)
      Rate.new(Connection.new.post('/rates', CreateRateQuery.new(params).to_query).parsed_response[:data])
    end
  end
end
