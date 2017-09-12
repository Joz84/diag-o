class BookingsController < ApplicationController
  $count = 0

  def show
  end

  def index
    @bookings = Booking.all
    @user = current_user
  end

  def new
    @bookings = Booking.all
  end

  def create
    @user = current_user
    @new_booking = Booking.new( user_id: User.find_by_first_name("Jo").id,
                                housing_id: 1,
                                set_at: params[:data_form][:value1],
                                start_hour: params[:data_form][:value2],
                                comment: Faker::Name.unique.name,
                                )
    if @new_booking.save
      redirect_to new_booking_path
    else
      raise
    end
    $count += 1
  end

  def delete
  end
end
