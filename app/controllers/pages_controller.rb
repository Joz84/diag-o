class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :eligibility]

  def home

  end

  def eligibility
    @address = params[:query][:address]
  end

  def eligibility
    @array = []
    @ZoneTest = Zone.first.points.each do |p|
      h = {}
      h['lat'] = p.lat
      h['lng'] = p.lng
      @array << h
    end
  end
end





