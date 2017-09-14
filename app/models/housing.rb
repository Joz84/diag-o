class Housing < ApplicationRecord
  has_many :bookings
  has_many :user_housings
  has_many :users, through: :user_housings

  delegate :diagnostician, to: :bookings, allow_nil: true

  geocoded_by :address
  after_validation :geocode, if: :address_changed?
end
