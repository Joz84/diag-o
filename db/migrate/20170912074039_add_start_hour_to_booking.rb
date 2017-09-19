class AddStartHourToBooking < ActiveRecord::Migration[5.1]
  def change
    add_column :bookings, :start_hour, :string
  end
end
