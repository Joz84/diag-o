class Diagnostician::BookingsController < ApplicationController
  def index
    @bookings = Booking.where(diagnostician: current_user)
    @dates = @bookings.map{ |booking| booking.set_at}
    @user = current_user
  end

  def show

  end

  def create
  end

  def destroy
  end
end
