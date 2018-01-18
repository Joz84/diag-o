class Diagnostician::HousingsController < ApplicationController
  def new
    @housing = policy_scope(Housing).new
    authorize @housing

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

  def create
  end

  def update
  end

  def delete
  end

  def index
    policy_scope(Housing)
    @housings = Housing.all.select{ |h| h.bookings.presence && h.address != "Diagnostician house" }
  end

  def valuations
    policy_scope(Housing)
    @housings = Housing.where(only_valuation: true)
    authorize @housings
  end

  private

  def minimum_for_valuation
    if params[:query]
      params[:query][:geoloc] && params[:query][:surface] && params[:query][:floor]
    else
      false
    end
  end
end
