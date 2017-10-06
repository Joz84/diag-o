class BookingsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :create]


  def show
    @booking = Booking.find(params[:id])
  end

  def index
    @bookings = policy_scope(Booking).where(diagnostician: current_user)
    @dates = @bookings.map{ |booking| booking.set_at}
    @user = User.find_by_first_name("Jo")
    authorize @bookings
  end

  def new
    @bookings = Booking.all
  end

  def create
    @diagnostician = User.find_by_first_name("Jo")

    authorize @diagnostician

    if current_user.diagnostician?
      @booking = @diagnostician.bookings.new(booking_params)
      @booking.diagnostic = Diagnostic.new
      # @booking.housing = current_user.particulier? ? current_user.housing : nil
      @booking.housing = Housing.first ## POUR TEST
      if @booking.save
        redirect_to bookings_path
      else
        flash[:alert] = t('fash.booking_save_error')
      end
    else
      housing = Housing.create!(address: session[:address])
      user_housing = UserHousing.create!(user: current_user, housing: housing, user_state: 1 )
      diagnostic = Diagnostic.new
      date = session[:date]
      hour = session[:hour]
      booking = Booking.create!(user: @diagnostician, housing: housing, diagnostic: diagnostic, set_at: DateTime.parse(date.to_s + " 0"+ hour + ":00:00 +0000"), comment:"Booking eligible n°#{Booking.count}", confirmed_at: nil)
      if housing.save! && user_housing.save! && diagnostic.save! && booking.save!
        flash[:notice] = t('flash.booking_save_ok')
        redirect_to user_path(current_user)
      else
        redirect_to confirmation_path
      end
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
