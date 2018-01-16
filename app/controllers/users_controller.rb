class UsersController < ApplicationController
  before_action :params_user, only: [:show]

  def show
    authorize @user
    if @user.diagnostician?
      @private_bookings = ownbookings(@user)
      @private_housings = @private_bookings.map{ |b| b.housing if b.housing.localized }
      draw_marker(@private_housings)
      @diagnostics = @user.diagnostics.last(3).reverse
      @bookings = Booking.incoming(@user).last(2)
    else
      @bookings = @user.housings.map { |h| h.bookings }.flatten
      draw_marker(@user.housings)
      @diagnostics = @user.housings.map { |h| h.bookings.first.diagnostic }
    end
  end

  private

  def params_user
    @user = User.find(params[:id])
  end
end
