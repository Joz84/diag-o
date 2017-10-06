class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :eligibility]
  before_action :params_user, only: [:home, :valuation]
  require "open-uri"

  def home
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
      zonepoints = zone.points.map { |point| {'lat' => point.lat.to_f, 'lng' => point.lng.to_f} }
      [ zonepoints, zone.color ]
    end
  end

  def valuation
    if minimum_for_valuation
      url_queue = []

      params[:query].each do |value|
        url_queue << "&#{value}=#{params[:query][value]}"
      end

      bdv_url = "https://bdvapis.appspot.com/#{ENV['BDV_API_KEY']}/valuation/v1.0.0/purchase?#{url_queue.join[1..-1]}"
      # bdv_url = "https://jsonplaceholder.typicode.com/posts"

      url_serialized = open(bdv_url, "Referer" => "http://www.ruby-lang.org/", "Origin" => "http://localhost:3000").read
      result = JSON.parse(url_serialized)
    else
      flash[:notice] = t('valuation.form_rescue')
    end
  end

  private

  def params_user
    @user = current_user
  end

  def minimum_for_valuation
    if params[:query]
      params[:query][:geoloc] && params[:query][:surface]
    else
      false
    end
  end
end
