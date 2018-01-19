class Diagnostician::HousingsController < ApplicationController
  def new
    @housing = policy_scope(Housing).new
    authorize @housing
  end

  def create
    policy_scope(Housing)
    @housing = Housing.new(housing_params)
    authorize @housing
    if @housing.save
      session[:geoloc] = @housing.geoloc
      session[:floor] = @housing.floor
      session[:rooms] = @housing.rooms
      session[:surface] = @housing.surface
      session[:construction_quality] = @housing.construction_quality
      session[:bathroom_quality] = @housing.bathroom_quality
      session[:living_quality] = @housing.living_quality
      session[:rooms_quality] = @housing.rooms_quality
      session[:parking_lot] = @housing.parking_lot
      session[:basement] = @housing.basement
      session[:elevator] = @housing.elevator
      session[:concierge] = @housing.concierge
      session[:collective_heating] = @housing.collective_heating
      session[:balcony] = @housing.balcony
      redirect_to new_diagnostician_housing_path
    else
      redirect_to diagnostician_valuations_path
    end

    # if minimum_for_valuation
    #   url_queue = []
    #   params[:query].each do |value|
    #     url_queue << "&#{value}=#{params[:query][value]}"
    #   end

    #   url = "https://bdvapis.appspot.com/#{ENV['BDV_API_KEY']}/valuation/v1.0.0/purchase?#{url_queue.join[1..-1]}"

    #   header = {'origin': "http://diag-o.herokuapp.com"}

    #   body = begin
    #     RestClient.get(url, headers = header)
    #   rescue => e
    #     e.response.body
    #   end

    #   response = JSON.parse(body)

    #   if e && JSON.parse(e.response.body)["status"]
    #     @error = "Error:" + JSON.parse(e.response.body)["message"]
    #   else
    #     @price = response["results"]["valuation"]["asset_standard_price"].to_i.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1 ').reverse
    #   end

    #   render :new
    # else
    #   # flash[:notice] = t('valuation.form_rescue')
    # end
  end

  def update
  end

  def delete
  end

  def index
    policy_scope(Housing)
    @housings = Housing.all.select{ |housing| housing.bookings.presence && housing.geoloc != "Diagnostician house" }
  end

  def valuations
    policy_scope(Housing)
    housings = Housing.where(only_valuation: true)
    authorize housings
    @housings = housings.reverse
  end

  private

  def minimum_for_valuation
    if params[:query]
      params[:query][:geoloc] && params[:query][:surface] && params[:query][:floor]
    else
      false
    end
  end

  def housing_params
    params.require(:housing).permit(:geoloc,
                                    :floor,
                                    :rooms,
                                    :surface,
                                    :construction_quality,
                                    :kitchen_quality,
                                    :bathroom_quality,
                                    :living_quality,
                                    :rooms_quality,
                                    :parking_lot,
                                    :basement,
                                    :elevator,
                                    :concierge,
                                    :balcony,
                                    :collective_heating,
                                    :valuation,
                                    :only_valuation,
                                     )
  end
end
