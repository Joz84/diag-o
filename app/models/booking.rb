class Booking < ApplicationRecord
  belongs_to :diagnostician, class_name: "User", foreign_key: "user_id"
  belongs_to :housing
end
