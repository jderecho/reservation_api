class ReservationPayloadParser
  class InvalidFormatError < StandardError; end

  PARSERS = [
    {
      matcher: ->(data) { data.key?("reservation") },
      parser: ->(data) {
        reservation = data["reservation"]
        guest_details = reservation["guest_details"]
        {
          start_date: reservation.dig("start_date"),
          end_date: reservation.dig("end_date"),
          number_of_guests: reservation.dig("number_of_guests"),
          number_of_nights: reservation.dig("nights"),
          number_of_adults: guest_details.dig("number_of_adults"),
          number_of_children: guest_details.dig("number_of_children"),
          number_of_infants: guest_details.dig("number_of_infants"),
          security_price: reservation.dig("listing_security_price_accurate"),
          payout_price: reservation.dig("expected_payout_amount"),
          total_price: reservation.dig("total_paid_amount_accurate"),
          host_currency: reservation.dig("host_currency"),
          guest: {
            id: reservation.dig("guest_id"),
            email: reservation.dig("guest_email"),
            first_name: reservation.dig("guest_first_name"),
            last_name: reservation.dig("guest_last_name"),
            phone: guest_details.dig("guest_phone_numbers")
          }
        }
      }
    },
    {
      matcher: ->(data) { data.key?("guests") },
      parser: ->(data) {
        guest = data["guest"]
        {
          start_date: data.dig("start_date"),
          end_date: data.dig("end_date"),
          number_of_guests: data.dig("guests"),
          number_of_nights: data.dig("nights"),
          number_of_adults: data.dig("adults"),
          number_of_children: data.dig("children"),
          number_of_infants: data.dig("infants"),
          security_price: data.dig("security_price"),
          payout_price: data.dig("payout_price"),
          total_price: data.dig("total_price"),
          host_currency: data.dig("currency"),
          guest: {
            id: guest.dig("id"),
            email: guest.dig("email"),
            first_name: guest.dig("first_name"),
            last_name: guest.dig("last_name"),
            phone: guest.dig("phone_numbers")
          }
        }
      }
    }
    # Add more parsers here
  ]

  def self.parse(payload)
    data = JSON.parse(payload)

    PARSERS.each do |parser|
      # If the matcher returns true, use that parser
      return parser[:parser].call(data) if parser[:matcher].call(data)
    end

    # If no parser matches, raise an error
    raise InvalidFormatError, "Unable to parse payload format"
  end
end
