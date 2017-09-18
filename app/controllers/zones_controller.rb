class ZonesController < ApplicationController

  def update
    Zone.all.each do |zone|
      zone.latitude.nil?
        zone.latitude = zone.points.first.lat
      zone.longitude.nil?
        zone.longitude = zone.points.first.lng
      zone.save!
    end
  end

end
