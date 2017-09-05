class Housing < ApplicationRecord
  belongs_to :booking
  has_many :user_housings
  has_many :users, through: :user_housings

  delegate :diagnostician, to: :bookings, allow_nil: true
end
