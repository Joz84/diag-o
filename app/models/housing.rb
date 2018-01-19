class Housing < ApplicationRecord
  has_many :bookings
  has_many :user_housings
  has_many :users, through: :user_housings

  delegate :diagnostician, to: :bookings, allow_nil: true

  geocoded_by :geoloc
  after_validation :geocode, if: :geoloc_changed?

  validates :geoloc, presence: true
  validates :floor, presence: true
  validates :surface, presence: true
  validates :rooms, presence: true

  def location
    self.latitude.presence
  end
end
