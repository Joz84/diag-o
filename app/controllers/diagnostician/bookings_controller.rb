class Diagnostician::BookingsController < ApplicationController
  before_action :params_booking, only: [:show, :destroy, :update]

  def index
    @bookings = Booking.where(diagnostician: current_user)
    @dates = @bookings.map{ |booking| booking.set_at}
    @user = current_user
  end

  def show
    authorize @booking
    @booking = Booking.find(params[:id])
    @housing = @booking.housing
    @hash = Gmaps4rails.build_markers(@housing) do |housing, marker|
      marker.lat housing.latitude
      marker.lng housing.longitude
      marker.json({ address: housing.address })
    end
  end

  def create
    authorize @booking
  end

  def destroy
    @booking.destroy
    redirect_back(fallback_location: root_path)
  end

  def update
    @booking.update( confirmed_at: @booking.confirmed_at ? nil : DateTime.now )
    authorize @booking
    redirect_back(fallback_location: root_path)
  end

  private

  def params_booking
    @booking = Booking.find(params[:id])
    @user = current_user

  end


end
