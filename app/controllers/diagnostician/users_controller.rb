class Diagnostician::UsersController < ApplicationController
  def show
    @user = current_user
    @bookings = Booking.all
    # prendre les bookings du diagnosticiens
    @mybookings = Booking.all.where(diagnostician: current_user)
    # récupérer les housings correspondant
    allhousings = @mybookings.map { |b| b.housing unless (b.housing.latitude.nil? || b.housing.longitude.nil?) }
    @myhousings = allhousings.compact
    # stocker chaque lat long en un hash
    @hash = Gmaps4rails.build_markers(@myhousings) do |housing, marker|
      marker.lat housing.latitude
      marker.lng housing.longitude
      marker.json({ address: housing.address })

    @bookings = Booking.incoming(current_user)
    end
  end
end
