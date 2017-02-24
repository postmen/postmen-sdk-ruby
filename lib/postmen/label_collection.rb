class Postmen
  # This class wraps the array of Label models
  class LabelCollection
    include CollectionProxy

    model Label
    key :labels

    # Fetch all labels.
    #
    # @param options [Hash] Options for the query.
    # @see https://docs.postmen.com/api.html#labels-list-all-labels API documentation
    # @example
    #   .all # Returns all labels, default query.
    #   .all(status: :cancelled) # Returns only cancelled labels
    def self.all(options = {})
      new(Connection.new.get('/labels', LabelQuery.new(options).to_query).parsed_response)
    end

    # Fetch single label
    #
    # @param id [UUID] Label UUID
    # @see https://docs.postmen.com/api.html#labels-retrieve-a-label API documentation
    # @return [Label]
    # @raise ResourceNotFound if label with given id was not fount
    def self.find(id)
      get(Connection.new.get("/labels/#{id}").parsed_response)
    end

    # Creates a label
    #
    # @param params [Hash] Label params
    # @see https://docs.postmen.com/api.html#labels-create-a-label API documentation
    # @return [Label]
    def self.create(params)
      Label.new(Connection.new.post('/labels', CreateLabelQuery.new(params).to_query).parsed_response[:data])
    end
  end
end
