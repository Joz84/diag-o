class Booking < ApplicationRecord
  belongs_to :diagnostician, class_name: "User", foreign_key: "user_id"
  belongs_to :housing, optional: true
  validates :start_hour, presence: :true
  validates :set_at, presence: :true
  validates :user_id, presence: :true


  def self.particulier
    User.where(housing_id: self.housing)
  end


end
