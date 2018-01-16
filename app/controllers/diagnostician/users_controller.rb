class Diagnostician::UsersController < ApplicationController
  def index
    @user = current_user
    policy_scope(Booking)
    @bookings = decreasing_date(@user.private_bookings)
  end
end
