class Postmen
  # This class wraps the array of Manifest models
  class ManifestCollection
    include CollectionProxy

    model Manifest
    key :manifests

    # Fetch all manifests.
    #
    # @param options [Hash] Options for the query.
    # @see https://docs.postmen.com/api.html#manifests-list-all-manifests API Documentation
    # @example
    #   .all # Returns all manisfests, default query.
    #   .all(status: :failed) # Returns only failed manifests
    def self.all(options = {})
      new(Connection.new.get('/manifests', ManifestQuery.new(options).to_query).parsed_response)
    end

    # Fetch single manifest
    #
    # @param id [UUID] Manifest UUID
    # @see https://docs.postmen.com/api.html#manifests-retrieve-a-manifest API documentation
    # @return [Manifest]
    # @raise ResourceNotFound if Manifest with given id was not found
    def self.find(id)
      get(Connection.new.get("/manifests/#{id}").parsed_response)
    end

    # Creates a Manifest
    #
    # @param params [Hash] Manifest params
    # @see https://docs.postmen.com/api.html#manifests-create-a-manifest API documentation
    # @return [Rate]
    def self.create(params)
      Manifest.new(Connection.new.post('/manifests', CreateManifestQuery.new(params).to_query).parsed_response[:data])
    end
  end
end
