class UsersController < ApplicationController
  before_action :params_user, only: [:show]

  def show
    authorize @user
    if @user.diagnostician?
      @private_bookings = @user.bookings.where(diagnostician: @user)
      @private_housings = @private_bookings.map { |b| b.housing unless (b.housing.latitude.nil? || b.housing.longitude.nil?) }.compact.last(2)
      draw_marker(@private_housings)
      @diagnostics = @user.diagnostics.last(3).reverse
      @bookings = Booking.incoming(@user).last(2)
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
end
