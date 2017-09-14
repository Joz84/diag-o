class Booking < ApplicationRecord
  belongs_to :diagnostician, class_name: "User", foreign_key: "user_id"
  belongs_to :housing, optional: true
  belongs_to :diagnostic
  validates :set_at, presence: :true
  validates :user_id, presence: :true

  def booker
    self.housing.users.first
  end
end
