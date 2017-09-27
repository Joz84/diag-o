class InscriptionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:disponibility, :checkpoint]
  after_action :verify_authorized, except: [:disponibility, :checkpoint, :confirmation]

  def disponibility
    @user = User.find_by_first_name("Jo")
    @bookings = Booking.where(diagnostician: @user)
    @dates = @bookings.map{ |booking| booking.set_at}

    session[:address] = params[:query][:address]
    session[:color] = params[:query][:color]
    session[:page] = 1
  end

  def checkpoint
   session[:date] = params[:query][:date]
   session[:hour] = params[:query][:hour]
   session[:page] = 2
   redirect_to new_user_registration_path
  end

  def confirmation
    session[:page] = 3
  end
end
