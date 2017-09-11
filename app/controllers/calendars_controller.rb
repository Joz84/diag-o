class CalendarsController < ApplicationController
  def create
    @calendar = current_user.calendar
    @newbooking = @calendar.bookings.build(booking_params) #creates event in creator's calendar

    @participant_ids = params[:id_array]

    @participant_ids.each do |item| #iterates through id array, finds corresponding customer and creates event
      @participant = User.find(item)
      @part_calendar = @participant.calendar
      @part_event = @part_calendar.bookings.build(booking_params) #adds event to participant's calendar
    end

    if @newevent.save
      redirect_to '/main' #'/main/#{@calendar.id}'
    else
      redirect_to '/compose'
    end
  end
end
