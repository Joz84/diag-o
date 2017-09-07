class Town < ApplicationRecord
  validates :zipcode, uniqueness: true
  has_many :zones
end
