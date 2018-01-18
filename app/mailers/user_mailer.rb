class UserMailer < ApplicationMailer

  def new_booking(booking)
    @booking = booking
    @user = @booking.booker
    @date = @booking.set_at.strftime("%d %b %Y")
    @hour = @booking.set_at.strftime("%H")
    @address = @booking.housing.geoloc
    mail(to: @user.email, subject: I18n.t('mail.new_booking'))
  end
end
