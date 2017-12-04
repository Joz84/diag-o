class BookingsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create]
  after_action :verify_authorized
  before_action :params_booking, only: [:show, :destroy]
  skip_before_action :authenticate_user!, only: [:show, :create]

  def show
  end

  def index
    @bookings = policy_scope(Booking).where(diagnostician: current_user)
    authorize @bookings
    @dates = @bookings.map{ |booking| booking.set_at}
    @user = User.thediagnostician
    authorize @bookings
  end

  def new
    @bookings = Booking.all
  end

  def create
    diagnostician = User.thediagnostician

    authorize diagnostician

    if current_user.diagnostician?
      booking = diagnostician.bookings.new(booking_params)
      authorize booking
      booking.diagnostic = Diagnostic.new
      # @booking.housing = current_user.particulier? ? current_user.housing : nil
      booking.housing = Housing.first # TEMPORAIRE
      if booking.save
        redirect_to bookings_path
      else
        (flash[:alert] = t('commons.issue'))
      end
    else
      @housing = Housing.create!(address: session[:address])
      @user_housing = UserHousing.create!(user: current_user, housing: @housing, user_state: 1 )
      @diagnostic = Diagnostic.create!
      authorize @diagnostic
      date = session[:date]
      hour = session[:hour]
      @booking = Booking.new(user: diagnostician,
                            housing: @housing,
                            diagnostic: @diagnostic,
                            set_at: DateTime.parse(date.to_s + " 0"+ hour + ":00:00 +0000"),
                            comment:"Booking eligible n°#{Booking.count}",
                            confirmed_at: nil)
      authorize @booking
      if @housing.save! && @user_housing.save! && @diagnostic.save! && @booking.save!
        redirect_to user_path(current_user)
        UserMailer.new_booking(@booking).deliver_now
        flash[:notice] = t('inscription.confirmation')
      else
        redirect_to confirmation_path
        flash[:alert] = t('commons.issue')

      end
    end
  end

  def destroy
    authorize @booking
    redirect_to bookings_path if @booking.destroy
  end

  private

  def params_booking
    @booking = Booking.find(params[:id])
  end


  def booking_params
    params.require(:booking).permit(:set_at, :comment, :id)
  end

end
