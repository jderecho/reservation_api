class GuestBuilder
  attr_reader :attrs, :guest

  # This method is used to initialize a GuestBuilder object
  # @params attrs [Hash] the attributes to initialize the object with
  # @return [GuestBuilder] the guest builder object
  def initialize(attrs)
    @attrs = attrs
    initialize_attributes
  end

  # This method is used to save a guest record
  # @return [Guest] the guest record
  def save
    ActiveRecord::Base.transaction do
      build_guest
      @guest.save! unless @guest.persisted?
    end
    @guest
  end

  private

  # This method is used to initialize the attributes of the guest builder object
  def initialize_attributes
    @email = attrs.fetch(:email, nil)
    @first_name = attrs.fetch(:first_name, nil)
    @last_name = attrs.fetch(:last_name, nil)
    @phone_numbers = attrs.fetch(:phone_numbers, "")
  end

  # This method is used to build a guest record
  # @return [Guest] the guest record
  def build_guest
    unless (@guest = find_by_email)
      @guest = Guest.new(
        email: @email,
        first_name: @first_name,
        last_name: @last_name,
        phone_numbers: @phone_numbers
      )
    end
  end

  # @return [Guest] the guest record
  def find_by_email
    Guest.find_by(email: @email)
  end
end
