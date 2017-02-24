class Postmen
  # This class holds all the logic behind preparing query for
  # creating a Label. It does type convertion, removes empty values and so on.
  # @see LabelCollection#create Usage
  class CreateLabelQuery < Dry::Struct
    constructor_type :strict_with_defaults

    attribute :service_type, Types::String
    attribute :shipper_account, Types::Reference
    attribute :shipment, Shipment
    attribute :async, Types::Bool.optional.default(nil)
    attribute :return_shipment, Types::Bool.optional.default(nil)
    attribute :paper_size, Types::PaperSize.optional.default(nil)
    attribute :ship_date, Types::String.optional.default(nil)
    # attribute :service_options
    attribute :is_document, Types::Bool.optional.default(nil)
    attribute :invoice, Types::Invoice.optional.default(nil)
    attribute :billing, Types::Billing.optional.default(nil)
    attribute :customs, Types::Customs.optional.default(nil)

    # Converts query object to hash
    # @return [Hash]
    def to_query
      {
        json: query
      }
    end

    private

    def query
      to_hash.reject { |_k, v| v.nil? }
    end
  end
end
