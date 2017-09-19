class UsersController < ApplicationController
  before_action :params_user, only: [:show]

  def show
    @bookings = Booking.all.where(diagnostician: @user)
    @myhousings = @bookings.map { |b| b.housing unless (b.housing.latitude.nil? || b.housing.longitude.nil?) }.compact
    @hash = Gmaps4rails.build_markers(@myhousings) do |housing, marker|
      marker.lat housing.latitude
      marker.lng housing.longitude
      marker.json({ address: housing.address })
    end
    @bookings = Booking.incoming(current_user)
    @diagnostics = Diagnostic.last(3).reverse
  end

  private

  def params_user
    @user = User.find(params[:id])
  end

end
