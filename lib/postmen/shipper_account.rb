class Postmen
  # Shipper account object
  # (brief information for rate and manifest responses)
  # @see https://docs.postmen.com/api.html#shipper-account-information API Documentation
  class ShipperAccount < Dry::Struct
    attribute :id, Types::UUID
    attribute :address, Types::Address
    attribute :slug, Types::String
    attribute :description, Types::String
    attribute :type, Types::ShipperAccountTypes
    attribute :timezone, Types::Timezone
    attribute :created_at, Types::DateTime
    attribute :updated_at, Types::DateTime

    # Returns all ShipperAccounts
    #
    # @see ShipperAccountCollection#all
    # @return [ShipperAccountCollection] Collection of ShipperAccounts
    def self.all(options = {})
      ShipperAccountCollection.all(options)
    end

    # Fetches single ShipperAccount
    #
    # @see ShipperAccountCollection#find
    # @return [ShipperAccount]
    def self.find(id)
      ShipperAccountCollection.find(id)
    end

    # Creates an instance of ShipperAccount
    #
    # @see ShipperAccountCollection#create
    # @return [ShipperAccount]
    def self.create(params)
      ShipperAccountCollection.create(params)
    end

    # Deletes given ShipperAccount
    #
    # @see https://docs.postmen.com/api.html#shipper-accounts-delete-a-shipper-account API Documentation
    def destroy
      Connection.new.delete("/shipper-accounts/#{@id}")
    end

    # Update a ShipperAccount credentials
    #
    # @see https://docs.postmen.com/api.html#shipper-accounts-update-a-shipper-account-credentials
    def update_credentials(params = {})
      Connection.new.put(
        "/shipper-accounts/#{@id}/credentials",
        ShipperAccountUpdateCredentialsQuery.new(params).to_hash
      )
    end

    # Update a shipper account information
    #
    # @see https://docs.postmen.com/api.html#shipper-accounts-update-a-shipper-account-information API Documentation
    def update(params = {})
      Connection.new.put("/shipper-accounts/#{@id}/info", ShipperAccountUpdateQuery.new(params).to_query)
    end
  end
end
