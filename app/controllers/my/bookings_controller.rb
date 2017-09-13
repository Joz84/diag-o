class My::BookingsController < ApplicationController

  def index
    @bookings = Booking.all.where(diagnostician: current_user)
  end


end
