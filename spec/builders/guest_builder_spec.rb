require 'rails_helper'

RSpec.describe GuestBuilder do
  let(:attrs) do
    {
      email: Faker::Internet.email,
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      phone_numbers: Faker::PhoneNumber.phone_number
    }
  end

  describe '#initialize' do
    it 'initializes the builder with the correct attributes' do
      guest_builder = described_class.new(attrs)

      expect(guest_builder.attrs).to eq(attrs)
    end
  end

  describe '#save' do
    it 'creates a new guest' do
      guest_builder = described_class.new(attrs)
      expect { guest_builder.save }.to change(Guest, :count).by(1)

      guest = guest_builder.guest
      expect(guest.email).to eq(attrs[:email])
      expect(guest.first_name).to eq(attrs[:first_name])
      expect(guest.last_name).to eq(attrs[:last_name])
      expect(guest.phone_numbers).to eq(attrs[:phone_numbers])
    end

    it 'returns the guest' do
      guest_builder = described_class.new(attrs)
      guest = guest_builder.save

      expect(guest).to be_a(Guest)
      expect(guest).to be_persisted
    end

    context 'when guest is existing' do
      it 'does not create a new guest' do
        guest = create(:guest)
        guest_builder = described_class.new(attrs.merge({email: guest.email}))

        expect { guest_builder.save }.not_to change(Guest, :count)
      end

      it 'returns the existing guest' do
        guest = create(:guest)
        guest_builder = described_class.new(attrs.merge({email: guest.email}))
        result = guest_builder.save

        expect(result).to eq(guest)
      end
    end

    context 'when email is invalid' do
      it 'raises an error' do
        guest_builder = described_class.new(attrs.merge({email: 'invalid_email'}))

        expect { guest_builder.save }.to raise_error(ActiveRecord::RecordInvalid)
      end

      context 'when email is missing' do
        it 'raises an error' do
          guest_builder = described_class.new(attrs.merge({email: nil}))

          expect { guest_builder.save }.to raise_error(ActiveRecord::RecordInvalid)
          expect(guest_builder.guest.errors.full_messages).to include("Email can't be blank")
        end
      end
    end

    context 'when first_name is missing' do
      it 'raises an error' do
        guest_builder = described_class.new(attrs.merge({first_name: nil}))

        expect { guest_builder.save }.to raise_error(ActiveRecord::RecordInvalid)
        expect(guest_builder.guest.errors.full_messages).to include("First name can't be blank")
      end
    end

    context 'when last_name is missing' do
      it 'raises an error' do
        guest_builder = described_class.new(attrs.merge({last_name: nil}))

        expect { guest_builder.save }.to raise_error(ActiveRecord::RecordInvalid)
        expect(guest_builder.guest.errors.full_messages).to include("Last name can't be blank")
      end
    end
  end
end