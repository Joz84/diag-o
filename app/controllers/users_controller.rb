class UsersController < ApplicationController

  def show
    @user = current_user
    @buttons = t('buttons')
    @bookings = Booking.all
  end
end
