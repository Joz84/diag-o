class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :private_diagnostics

  include Pundit

  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?


  def set_locale
    I18n.locale = :fr
    @buttons = t('buttons')
  end

  def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :role, :phone])
      # devise_parameter_sanitizer.permit(:account_update, keys: user_data)
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

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(root_path)
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

end
