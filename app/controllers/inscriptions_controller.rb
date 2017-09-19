class InscriptionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:disponibility]

  def disponibility
    @user = User.find_by_first_name("Jo")
    @bookings = Booking.where(diagnostician: @user)
    @dates = @bookings.map{ |booking| booking.set_at}

    session = { address: params[:query][:address] }
    # session[:infos][:eligibility]
    # session[:infos][:booking]
    # session[:infos]
  end

  def checkpoint

  end

  def confirmation

  end
end
