class Postmen
  # This class wraps the array of ShipperAccount models
  class ShipperAccountCollection
    include CollectionProxy

    model ShipperAccount
    key :shipper_accounts

    # Fetch all shipper accounts.
    #
    # @param options [Hash] Options for the query.
    # @see https://docs.postmen.com/api.html#shipper-accounts-list-all-shipper-accounts API documentation
    # @example
    #   .all # Returns all shipper accounts, default query.
    #   .all(slug: :aramex) # Returns only Shipper accounts from Aramex
    def self.all(options = {})
      new(Connection.new.get('/shipper-accounts', ShipperAccountQuery.new(options).to_query).parsed_response)
    end

    # Fetch single ShipperAccount
    #
    # @param id [UUID] ShipperAccount UUID
    # @see https://docs.postmen.com/api.html#shipper-accounts-retrieve-a-shipper-account API documentation
    # @return [ShipperAccount]
    # @raise ResourceNotFound if ShipperAccount with given id was not found
    def self.find(id)
      get(Connection.new.get("/shipper-accounts/#{id}").parsed_response)
    end

    # Creates a ShipperAccount
    #
    # @param params [Hash] ShipperAccount params
    # @see https://docs.postmen.com/api.html#shipper-accounts-create-a-shipper-account API documentation
    # @return [ShipperAccount]
    def self.create(params)
      ShipperAccount.new(Connection.new.post('/shipper-accounts', CreateShipperAccountQuery.new(params).to_query).parsed_response[:data])
    end
  end
end
