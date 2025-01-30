class ReservationBuilder
  attr_reader :attrs

  # @params attrs [Hash] the attributes to initialize the object with
  def initialize(attrs = {})
    @attrs = attrs
    initialize_attributes
  end

  # This method is used to save a reservation record
  # @return [Reservation] the reservation record
  def save
    ActiveRecord::Base.transaction do
      find_or_create_guest!
      build_reservation
      @reservation.save!
    end
    @reservation
  end

  private

  def initialize_attributes
    @start_date = attrs.fetch(:start_date, nil)
    @end_date = attrs.fetch(:end_date, nil)
    @number_of_nights = attrs.fetch(:number_of_nights, 0)
    @number_of_guests = attrs.fetch(:number_of_guests, 0)
    @number_of_adults = attrs.fetch(:number_of_adults, 0)
    @number_of_children = attrs.fetch(:number_of_children, 0)
    @number_of_infants = attrs.fetch(:number_of_infants, 0)
    @security_price = attrs.fetch(:security_price, 0.0)
    @payout_price = attrs.fetch(:payout_price, 0.0)
    @total_price = attrs.fetch(:total_price, 0.0)
    @host_currency = attrs.fetch(:host_currency, "AUD")
  end

  # @return [Reservation] the reservation record
  def build_reservation
    @reservation = Reservation.new(
      start_date: @start_date,
      end_date: @end_date,
      number_of_nights: @number_of_nights,
      number_of_guests: @number_of_guests,
      number_of_adults: @number_of_adults,
      number_of_children: @number_of_children,
      number_of_infants: @number_of_infants,
      security_price: @security_price,
      payout_price: @payout_price,
      total_price: @total_price,
      host_currency: @host_currency,
      guest: @guest
    )
  end

  # @return [Guest] the guest record
  def find_or_create_guest!
    @guest = GuestBuilder.new(guest_attributes).save
  end

  # @return [Hash] the guest attributes
  def guest_attributes
    {
      id: attrs.dig(:guest, :id),
      email: attrs.dig(:guest, :email),
      first_name: attrs.dig(:guest, :first_name),
      last_name: attrs.dig(:guest, :last_name),
      phone_numbers: attrs.dig(:guest, :phone_numbers)
    }
  end
end
