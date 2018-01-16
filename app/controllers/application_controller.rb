class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :private_diagnostics
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized


  include Pundit

  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?


  def set_locale
    I18n.locale = :fr
    @buttons = t('buttons')
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :role, :phone])
  end

  def private_diagnostics
    self.housings.map { |housing| housing.bookings.first.diagnostic }
  end

  def after_sign_in_path_for(resource)
    if resource.sign_in_count == 1
      confirmation_path
    else
      root_path
    end
  end

  def user_not_authorized
    flash[:alert] = t('pundit.rescue')
    redirect_to request.referer || root_path
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

  def draw_marker(housings)
    @hash = Gmaps4rails.build_markers(housings) do |housing, marker|
      marker.lat housing.latitude
      marker.lng housing.longitude
      marker.json({ address: housing.address })
      marker.picture({ :url => "http://res.cloudinary.com/doodlid/image/upload/v1507545075/diago/diago_marker.svg", :width => 64,
        :height => 91 });
    end
  end

  def ownbookings(user)
    user.bookings.where(diagnostician: user).select{|booking| booking if !booking.selfbooked }
  end

end
