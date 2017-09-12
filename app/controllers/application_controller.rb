class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :set_locale

  include Pundit

  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?


  def set_locale
    I18n.locale = :fr
  end

  def configure_permitted_parameters
      user_data = [
        :first_name,
        :last_name,
        :address,
        :zipcode,
        :city,
        :complement,
        :phone,
        :specialty_id,
        :siret,
        :company,
        :iban,
        :avatar,
        :logistic
      ]

      devise_parameter_sanitizer.permit(:sign_up, keys: user_data)
      devise_parameter_sanitizer.permit(:account_update, keys: user_data)
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
