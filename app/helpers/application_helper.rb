module ApplicationHelper

  def half_day_is_booked?(date, start_hour)
    Booking.where(set_at: date, start_hour: start_hour).count == 0
  end

end
