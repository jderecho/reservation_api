class AddHostAndNumberOfInfantsToReservation < ActiveRecord::Migration[7.2]
  def change
    add_column :reservations, :host_currency, :string, default: 'AUD'
    add_column :reservations, :number_of_infants, :integer
  end
end
