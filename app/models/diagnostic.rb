class Diagnostic < ApplicationRecord
  has_one :booking

  def booker
    self.booking.housing.users.first
  end

end
