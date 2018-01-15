class UserMailerPreview < ActionMailer::Preview
  def welcome
    booking = Booking.first
    UserMailer.new_booking(booking)
  end
end
