class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :eligibility]

  def home

  end

  def eligibility
    @address = params[:query][:address]
  end
end
