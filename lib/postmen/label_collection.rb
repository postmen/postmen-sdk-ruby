class Postmen
  class LabelCollection
    include CollectionProxy

    model Label
    key :labels

    def self.all(options = {})
      new(Connection.new.get('/labels', LabelQuery.new(options).to_query).parsed_response)
    end

    def self.find(id)
      get(Connection.new.get("/labels/#{id}").parsed_response)
    end
  end
end
