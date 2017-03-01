class Postmen
  module Types
    # Item - element of shippment
    # @see https://docs.postmen.com/api.html#item API Documentation
    class Item < Dry::Struct
      constructor_type :schema

      attribute :description, Types::String
      attribute :quantity, Types::Int
      attribute :price, Types::Money
      attribute :weight, Types::Weight
      attribute :item_id, Types::String
      attribute :origin_country, Types::Country
      attribute :sku, Types::String
      attribute :hs_code, Types::String

      # Converts object to hash
      # @return [Hash]
      def to_hash
        super.reject { |_k, v| v.nil? }
      end
    end
  end
end
