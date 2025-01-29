class Reservation < ApplicationRecord
  belongs_to :guest
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :number_of_nights, presence: true
  validates :number_of_guests, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :number_of_adults, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :number_of_children, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validate :checkout_after_checkin
  validate :dates_not_in_past

  accepts_nested_attributes_for :guest
  
  private
  
  def checkout_after_checkin
    return if start_date.blank? || end_date.blank?
    
    if end_date <= start_date
      errors.add(:end_date, "must be after checkin date")
    end
  end
  
  def dates_not_in_past
    return if start_date.blank?
    
    if start_date < Date.current
      errors.add(:start_date, "can't be in the past")
    end
  end
end
