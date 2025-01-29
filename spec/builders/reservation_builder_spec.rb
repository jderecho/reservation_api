require 'rails_helper'

RSpec.describe ReservationBuilder do
  let(:start_date) { Date.current.strftime('%Y-%m-%d') }
  let(:end_date) { (Date.current + 1.day).strftime('%Y-%m-%d') }

  let(:attrs) do
    {
      start_date: start_date,
      end_date: end_date,
      number_of_guests: 4,
      number_of_nights: 4,
      number_of_adults: 2,
      number_of_children: 2,
      number_of_infants: 0,
      security_price: 500,
      payout_price: 3800.00,
      total_price: 4500.00,
      host_currency: 'AUD',
      guest: guest_attrs
    }
  end
  let(:guest_attrs) do
    {
      email: Faker::Internet.email,
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      phone_numbers: Faker::PhoneNumber.phone_number
    }
  end

  describe '#initialize' do
    subject { described_class.new(attrs) }

    it 'initializes the reservation builder with the correct attributes' do
      expect(subject.attrs).to eq(attrs)
      expect(subject.instance_variable_get(:@start_date)).to eq(start_date)
      expect(subject.instance_variable_get(:@end_date)).to eq(end_date)
      expect(subject.instance_variable_get(:@number_of_guests)).to eq(4)
      expect(subject.instance_variable_get(:@number_of_nights)).to eq(4)
      expect(subject.instance_variable_get(:@number_of_adults)).to eq(2)
      expect(subject.instance_variable_get(:@number_of_children)).to eq(2)
      expect(subject.instance_variable_get(:@number_of_infants)).to eq(0)
      expect(subject.instance_variable_get(:@security_price)).to eq(500)
      expect(subject.instance_variable_get(:@payout_price)).to eq(3800.00)
      expect(subject.instance_variable_get(:@total_price)).to eq(4500.00)
      expect(subject.instance_variable_get(:@host_currency)).to eq('AUD')
    end

    context 'when save is called' do
      subject { described_class.new(attrs) }

      it 'creates a new reservation' do
        expect { subject.save }.to change(Reservation, :count).by(1)
      end

      it 'returns the reservation' do
        reservation = subject.save
        expect(reservation).to be_a(Reservation)
        expect(reservation).to be_persisted
        expect(reservation.start_date).to eq(Date.parse(start_date))
        expect(reservation.end_date).to eq(Date.parse(end_date))
        expect(reservation.number_of_guests).to eq(4)
        expect(reservation.number_of_nights).to eq(4)
        expect(reservation.number_of_adults).to eq(2)
        expect(reservation.number_of_children).to eq(2)
        expect(reservation.number_of_infants).to eq(0)
        expect(reservation.security_price).to eq(500)
        expect(reservation.payout_price).to eq(3800.00)
        expect(reservation.total_price).to eq(4500.00)
        expect(reservation.host_currency).to eq('AUD')

        guest = reservation.guest
        expect(guest).to be_a(Guest)
        expect(guest).to be_persisted
        expect(guest.email).to eq(guest_attrs[:email])
        expect(guest.first_name).to eq(guest_attrs[:first_name])
        expect(guest.last_name).to eq(guest_attrs[:last_name])
        expect(guest.phone_numbers).to eq(guest_attrs[:phone_numbers])
      end
    end
  end
end
