require 'rails_helper'

RSpec.describe ReservationPayloadParser do
  let(:reservation_payload) do
    JSON.parse(File.read(Rails.root.join(reservation_payload_path)))
  end

  describe '#parse' do
    let(:parsed_data) { described_class.parse(reservation_payload.to_json) }
  
    context 'when parsing payload #1 with guests key' do
      let(:reservation_payload_path) { 'spec/fixtures/reservation.json' }

      it 'returns the parsed reservation data' do
        expect(parsed_data).to eq(
          start_date: '2021-03-12',
          end_date: '2021-03-16',
          number_of_guests: 4,
          number_of_nights: 4,
          number_of_adults: 2,
          number_of_children: 2,
          number_of_infants: 0,
          security_price: '500',
          payout_price: '3800.00',
          total_price: '4500.00',
          host_currency: 'AUD',
          guest: {
            id: 1,
            email: 'wayne_woodbridge@bnb.com',
            first_name: 'Wayne',
            last_name: 'Woodbridge',
            phone: nil
          }
        )
      end
    end

    context 'when parsing payload #2 with reservation key' do
      let(:reservation_payload_path) { 'spec/fixtures/reservation2.json' }

      it 'returns the parsed reservation data' do
        expect(parsed_data).to eq(
          start_date: '2021-03-12',
          end_date: '2021-03-16',
          number_of_guests: 4,
          number_of_nights: 4,
          number_of_adults: 2,
          number_of_children: 2,
          number_of_infants: 0,
          security_price: '500.00',
          payout_price: '3800.00',
          total_price: '4500.00',
          host_currency: 'AUD',
          guest: {
            id: 1,
            email: 'wayne_woodbridge@bnb.com',
            first_name: 'Wayne',
            last_name: 'Woodbridge',
            phone: nil
          }
        )
      end
    end
  end
end