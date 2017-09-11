class BookingsController < ApplicationController
  $count = 0

  def show
  end

  def index
    @bookings = Booking.all
    @user = current_user
  end

  def new

  end

  def create
    @user = current_user
    @new_booking = Booking.new( user_id: @user.id,
                                housing_id: 1,
                                set_at: params[:new_booking][:date],
                                comment: "Booking" + $count.to_s,
                                confirmed_at: Date.today+1)
    if @new_booking.save
      redirect_to bookings_path
    else
      raise
    end
    $count += 1
  end

  def delete
  end
end
