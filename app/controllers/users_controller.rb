class UsersController < ApplicationController
  before_action :params_user, only: [:show]

  def show
    authorize @user
    if @user.diagnostician?
      @private_bookings = @users.bookings.where(diagnostician: @user)
      @private_housings = @private_bookings.map { |b| b.housing unless (b.housing.latitude.nil? || b.housing.longitude.nil?) }.compact
      draw_marker(@private_housings)
      @diagnostics = @user.diagnostics.last(3).reverse
      end
      @bookings = Booking.incoming(@user)
    else
      @bookings = @user.housings.map { |housing| housing.bookings }.flatten
      draw_marker(@user.housings)
      @diagnostics = @user.housings.map { |housing| housing.bookings.first.diagnostic }
    end
  end

  private

  def params_user
    @user = User.find(params[:id])
  end

  def draw_marker(housings)
    Gmaps4rails.build_markers(housings) do |housing, marker|
      marker.lat housing.latitude
      marker.lng housing.longitude
      marker.json({ address: housing.address })
  end
end
