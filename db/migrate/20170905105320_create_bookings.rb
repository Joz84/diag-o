class CreateBookings < ActiveRecord::Migration[5.1]
  def change
    create_table :bookings do |t|
      t.references :user, foreign_key: true
      t.references :housing, foreign_key: true
      t.datetime :set_at
      t.text :comment
      t.datetime :confirmed_at

      t.timestamps
    end
  end
end
