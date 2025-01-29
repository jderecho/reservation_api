require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe 'associations' do
    it { should belong_to(:guest) }
  end

  describe 'validations' do
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:end_date) }
    it { should validate_presence_of(:number_of_nights) }
    it { should validate_presence_of(:number_of_guests) }
    it { should validate_numericality_of(:number_of_guests).only_integer.is_greater_than_or_equal_to(1) }
    it { should validate_presence_of(:number_of_adults) }
    it { should validate_numericality_of(:number_of_adults).only_integer.is_greater_than_or_equal_to(0) }
    it { should validate_presence_of(:number_of_children) }
    it { should validate_numericality_of(:number_of_children).only_integer.is_greater_than_or_equal_to(0) }
  
    describe 'checkout_after_checkin' do
      it 'validates that the end date is after the start date' do
        reservation = build(:reservation)
        expect(reservation).to be_valid
      end
  
      it 'is invalid if the end date is before the start date' do
        reservation = build(:reservation, start_date: Date.current + 1, end_date: Date.current)
        expect(reservation).not_to be_valid
        expect(reservation.errors[:end_date]).to include("must be after checkin date")
      end
    end

    describe 'dates_not_in_past' do
      it 'validates that the start date is not in the past' do
        reservation = build(:reservation, start_date: Date.current + 1, end_date: Date.current + 2)
        expect(reservation).to be_valid
      end
  
      it 'is invalid if the start date is in the past' do
        reservation = build(:reservation, start_date: Date.current - 1)
        expect(reservation).not_to be_valid
        expect(reservation.errors[:start_date]).to include("can't be in the past")
      end
    end
  end
end
