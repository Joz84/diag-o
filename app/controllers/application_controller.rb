class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

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
end
