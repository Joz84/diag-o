class Diagnostician::BookingsController < ApplicationController
  def index
    @bookings = Booking.where(diagnostician: current_user)
  end

  def create
  end

  def destroy
  end
end
