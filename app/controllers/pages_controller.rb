class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def eligibility
    @color = "blue"
    @area_orange = [
     { lat: 44.80359712236584, lng: -0.51317632796123 },
     { lat: 44.80343112410052,  lng:-0.517242017073627 },
     { lat: 44.803432239850856, lng:-0.517244698569879 },
     { lat: 44.803432923191316,  lng:-0.517242247997421 },
     { lat: 44.7917,  lng:-0.5161 },
     { lat: 44.7928,  lng:-0.5007 },
    ];
  end
end
