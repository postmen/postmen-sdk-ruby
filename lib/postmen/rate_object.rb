class Postmen
  # Rate record object
  #
  # @see https://docs.postmen.com/api.html#rates API documentation
  class RateObject < Dry::Struct
    attribute :shipper_account, Types::ShipperAccount
    attribute :service_type, Types::String
    attribute :service_name, Types::String
    attribute :charge_weight, Types::Weight
    attribute :total_charge, Types::Money
    attribute :pickup_deadline, Types::String
    attribute :booking_cut_off, Types::Date
    attribute :delivery_date, Types::String
    attribute :transit_time, Types::String
    attribute :detailed_charges, Types::Array.member(Types::DetailedCharges)
    attribute :info_message, Types::String
    attribute :error_message, Types::String
  end
end
