class AddDiagnosticToBookings < ActiveRecord::Migration[5.1]
  def change
    add_reference :bookings, :diagnostic, foreign_key: true
  end
end
