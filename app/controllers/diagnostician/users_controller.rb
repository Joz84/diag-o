class Diagnostician::UsersController < ApplicationController
  def index
    @user = current_user
    @bookings = policy_scope(Booking).where(diagnostician: @user).sort_by{|booking| booking.set_at}.select{|booking| booking.booker.diagnostician? == false}.reverse
    @housings = Housing.all
  end
end
