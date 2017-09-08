class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :eligibility]

  def home

  end

  def eligibility
    @address = params[:query][:address]
  end

  def eligibility
    # @zones = Zone.all
    # @zones.each_with_index do |zone, index|
    @town = Town.first
    @zoneslist = @town.zones.map do |zone|
      zoneinfos = []
      zoneinfos << zone.points.map do |point|
        {'lat' => point.lat.to_f, 'lng' => point.lng.to_f}
      end
      zoneinfos << ['#00FF00', '#FFA500', '#0000FF'].sample
      zoneinfos
    end
  end
end




# i=0
# Zone.all.each_with_index do |zone, index|
#   @pointslist = []
#   i +=1
#   puts "ZONE + #{i}"
#   zone.points.each do |point|
#     @pointslist << point
#   end
#     puts @pointslist.size
# end
