class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :eligibility]

  def home
    @user = current_user
  end

  def eligibility
    session[:address] = nil
    session[:color] = nil
    session[:date] = nil
    session[:hour] = nil

    unless params[:query].nil?
      @address = params[:query][:address]
      @address_geocoded = Geocoder.coordinates(params[:query][:address])
    end

    @town = Town.first
    @zoneslist = @town.zones.map do |zone|
      zoneinfos = []
      zoneinfos << zone.points.map do |point|
        {'lat' => point.lat.to_f, 'lng' => point.lng.to_f}
      end
      zoneinfos << zone.color
      zoneinfos
    end
  end
end
