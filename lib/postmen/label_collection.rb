class Postmen
  class LabelCollection
    include CollectionProxy

    model Label
    key :labels

    def self.all
      new(Connection.new.get("/labels").parsed_response)
    end
  end
end
