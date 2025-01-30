require 'rails_helper'

RSpec.describe ReservationSerializer do
  let(:reservation) { create(:reservation) }
  let(:serializer) { described_class.new(reservation) }
  let(:serialization) { serializer.as_json }

  it 'serializes the reservation' do
    expect(serialization).to eq({
      id: reservation.id,
      guest: {
        id: reservation.guest.id,
        first_name: reservation.guest.first_name,
        last_name: reservation.guest.last_name,
        email: reservation.guest.email
      },
      start_date: reservation.start_date,
      end_date: reservation.end_date,
      number_of_guests: reservation.number_of_guests,
      number_of_adults: reservation.number_of_adults,
      number_of_children: reservation.number_of_children,
      number_of_infants: reservation.number_of_infants,
      security_price: reservation.security_price,
      payout_price: reservation.payout_price,
      total_price: reservation.total_price,
      total_nights: (reservation.end_date - reservation.start_date).to_i,
      created_at: reservation.created_at
    })
  end
end
