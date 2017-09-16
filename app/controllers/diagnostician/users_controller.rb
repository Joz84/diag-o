class Diagnostician::UsersController < ApplicationController
  def show
    @user = current_user
    @bookings = Booking.all.where(diagnostician: @user)
    @myhousings = @bookings.map { |b| b.housing unless (b.housing.latitude.nil? || b.housing.longitude.nil?) }.compact
    @hash = Gmaps4rails.build_markers(@myhousings) do |housing, marker|
      marker.lat housing.latitude
      marker.lng housing.longitude
      marker.json({ address: housing.address })
    end
  end

  def index
    @user = current_user
    @bookings = Booking.where(diagnostician: @user).sort_by{|booking| booking.set_at}.reverse
    @housings = Housing.all
  end
end
