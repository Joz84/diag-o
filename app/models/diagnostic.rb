class Diagnostic < ApplicationRecord
  has_one :booking
  has_one :user, through: :booking
  has_one :diagnostician, through: :booking, class_name: "User", foreign_key: "user_id"

  def booker
    self.booking.housing.users.first
  end

end
