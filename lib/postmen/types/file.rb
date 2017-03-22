class Postmen
  module Types
    # File object
    # @see https://docs.postmen.com/api.html#a-files-object API Documentation
    class File < Dry::Struct
      attribute :url, Types::String
      attribute :file_type, Types::String
      attribute :paper_size, Types::String
    end
  end
end
