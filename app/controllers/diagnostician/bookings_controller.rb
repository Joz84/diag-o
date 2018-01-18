class Diagnostician::BookingsController < ApplicationController
  before_action :params_booking, only: [:show, :destroy, :update, :add_comment, :delete_comment]

  def index
    @bookings = policy_scope(Booking).where(diagnostician: current_user)
    authorize @bookings
    @dates = @bookings.map{ |booking| booking.set_at}
    @user = User.find_by_first_name("Jo") # TEMPORARY - There is only one diagnostician
    authorize @bookings
  end

  def show
    authorize @booking
    @housing = @booking.housing
    @hash = Gmaps4rails.build_markers(@housing) do |housing, marker|
      marker.lat housing.latitude
      marker.lng housing.longitude
      marker.json({ address: housing.address })
    end
  end

  def create
    diagnostician = User.find_by_first_name("Jo")

    authorize diagnostician

    if current_user.diagnostician?
      booking = diagnostician.bookings.new(booking_params)
      authorize booking
      booking.diagnostic = Diagnostic.new
      booking.housing = Housing.first # TEMPORARY - There is only one diagnostician, it housing needed in order to selfbook him
      if booking.save
        redirect_to diagnostician_bookings_path
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
        flash[:notice] = t('inscription.confirmation')
      else
        redirect_to confirmation_path
        flash[:alert] = t('commons.issue')

      end
    end
  end

  def destroy
    authorize @booking
    if @booking.booker.diagnostician?
      location = diagnostician_bookings_path
    else
      location = diagnostician_users_path
    end
    @booking.destroy
    redirect_to location
  end

  def update
    authorize @booking
    @booking.update( confirmed_at: @booking.confirmed_at ? nil : DateTime.now )
    authorize @booking
    redirect_back(fallback_location: root_path)
  end

  def add_comment
    authorize @booking
    @booking.comment = params[:query][:comment]
    @booking.save!
    redirect_back(fallback_location: root_path)
  end

  def delete_comment
    authorize @booking
    @booking.comment = nil
    @booking.save!
    redirect_back(fallback_location: root_path)
  end

  private

  def params_booking
    @booking = Booking.find(params[:id])
    @user = current_user
  end

  def booking_params
    params.require(:booking).permit(:set_at, :comment, :id)
  end


end
