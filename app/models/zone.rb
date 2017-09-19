class Zone < ApplicationRecord
  belongs_to :town
  has_many :points
  geocoded_by :address, :latitude  => :latitude, :longitude => :longitude # ActiveRecord
end
