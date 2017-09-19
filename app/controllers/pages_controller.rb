class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :eligibility]

  def home
    @user = current_user
  end

  def eligibility
    @address = Geocoder.coordinates(params[:query][:address])

    @town = Town.first
    @zoneslist = @town.zones.map do |zone|
      zoneinfos = []
      zoneinfos << zone.points.map do |point|
        {'lat' => point.lat.to_f, 'lng' => point.lng.to_f}
      end
      zoneinfos << zone.color
      zoneinfos
    end

    session[:infos][:address]
    session[:infos][:eligibility]
    session[:infos][:booking]

    session[:infos]
  end
end
