class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :eligibility]
  before_action :params_user, only: [:home, :valuation]


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

      url = "https://bdvapis.appspot.com/#{ENV['BDV_API_KEY']}/valuation/v1.0.0/purchase?#{url_queue.join[1..-1]}"

      header = {'origin': "http://diag-o.herokuapp.com"}

      body = begin
        RestClient.get(url, headers = header)
      rescue => e
        e.response.body
      end
      response = JSON.parse(body)

      if e && JSON.parse(e.response.body)["status"]
        @error = "Error:" + JSON.parse(e.response.body)["message"]
      else
        @price = response["results"]["valuation"]["asset_standard_price"].to_i.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1 ').reverse
      end

      render :valuation
    else
      # flash[:notice] = t('valuation.form_rescue')
    end
  end

  private

  def params_user
    @user = current_user
  end

  def minimum_for_valuation
    if params[:query]
      params[:query][:geoloc] && params[:query][:surface] && params[:query][:floor]
    else
      false
    end
  end
end
