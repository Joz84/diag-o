class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :eligibility]

  def home

  end

  def eligibility
    @address = params[:query][:address]
  end

  def eligibility
    @zones = Zone.all
    @zones.each do |zone|
    @pointslist = []
    zone.points.each do |point|
      point_hash = {}
      point_hash['lat'] = point.lat.to_f
      point_hash['lng'] = point.lng.to_f
      @pointslist << point_hash
    end
  end
end





