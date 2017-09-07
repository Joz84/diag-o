class Zone < ApplicationRecord
  belongs_to :town
  has_many :points
end
