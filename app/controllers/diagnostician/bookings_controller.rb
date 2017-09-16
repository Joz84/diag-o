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
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_back(fallback_location: root_path)
  end

  def update
    @booking = Booking.find(params[:id])
    if @booking.confirmed_at
      @booking.confirmed_at = nil
    else
      @booking.confirmed_at = DateTime.now
    end
    if @booking.save!
      redirect_back(fallback_location: root_path)
    end
  end

end
