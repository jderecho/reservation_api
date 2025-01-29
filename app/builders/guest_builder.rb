class GuestBuilder
  attr_reader :attrs, :guest

  def initialize(attrs)
    @attrs = attrs
    initialize_attributes
  end

  def save
    ActiveRecord::Base.transaction do
      build_guest
      @guest.save! unless @guest.persisted?
    end
    @guest
  end

  private

  def initialize_attributes
    @email = attrs.fetch(:email, nil)
    @first_name = attrs.fetch(:first_name, nil)
    @last_name = attrs.fetch(:last_name, nil)
    @phone_numbers = attrs.fetch(:phone_numbers, '')
  end

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

  def find_by_email
    Guest.find_by(email: @email)
  end
end