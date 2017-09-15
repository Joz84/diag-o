class BookingsController < ApplicationController
  def show
  end

  def index
    @bookings = Booking.where(diagnostician: current_user)
    @dates = @bookings.map{ |booking| booking.set_at}
    @user = current_user
  end

  def new
    @bookings = Booking.all
  end

  def create
    @user = current_user
    @diagnostician = User.find_by_first_name("Jo")
    @booking = @diagnostician.bookings.new(booking_params)
    @booking.diagnostic = Diagnostic.new
    # @booking.housing = current_user.particulier? ? current_user.housing : nil
    @booking.housing = Housing.last ## POUR TEST
    if @booking.save
      redirect_to bookings_path
    else
      raise
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    if @booking.destroy
      redirect_to bookings_path
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:set_at, :comment, :id)
  end
end
