class Postmen
  module Types
    # Address object
    #
    # @see https://docs.postmen.com/api.html#address API Documentation
    class Address < Dry::Struct
      constructor_type :strict_with_defaults

      attribute :country, Types::Country
      attribute :contact_name, Types::String.optional.default(nil)
      attribute :phone, Types::String.optional.default(nil)
      attribute :fax, Types::String.optional.default(nil)
      attribute :email, Types::String.optional.default(nil)
      attribute :company_name, Types::String.optional.default(nil)
      attribute :street1, Types::String.optional.default(nil)
      attribute :street2, Types::String.optional.default(nil)
      attribute :street3, Types::String.optional.default(nil)
      attribute :city, Types::String.optional.default(nil)
      attribute :state, Types::String.optional.default(nil)
      attribute :postal_code, Types::String.optional.default(nil)
      attribute :type, Types::AddressType.optional.default(nil)
      attribute :tax_id, Types::String.optional.default(nil)

      # Converts object to hash
      # @return [Hash]
      def to_hash
        super.reject { |_k, v| v.nil? }
      end
    end
  end
end
