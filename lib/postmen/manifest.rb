class Postmen
  # A manifest object object
  #
  # @see https://docs.postmen.com/api.html#a-manifest-object API Documentation
  class Manifest < Dry::Struct
    attribute :id, Types::UUID
    attribute :status, Types::ManifestStatuses
    attribute :shipper_account, Types::Reference
    attribute :labels, Types::Array # TODO: implement manifesting label type
    attribute :files, Types::Hash # TODO: Implement Files Type
    attribute :created_at, Types::DateTime
    attribute :updated_at, Types::DateTime

    # Returns all manifests
    #
    # @see ManifestCollection#all
    # @return [ManifestCollection] Collection of Manifests
    def self.all(options = {})
      ManifestCollection.all(options)
    end

    # Fetches single manifest
    #
    # @see ManifestCollection#find
    # @return [Manifest]
    def self.find(id)
      ManifestCollection.find(id)
    end

    # Creates an instance of manifest
    #
    # @see ManifestCollection#create
    # @return [Manifest]
    def self.create(params)
      ManifestCollection.create(params)
    end
  end
end
