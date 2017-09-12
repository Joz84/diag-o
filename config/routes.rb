Rails.application.routes.draw do

  devise_for :users
  root to: 'pages#home'
  get '/eligibility', to: 'pages#eligibility'


  resources :users, only: [:show] do
    resources :bookings, only: [:new, :create, :index]
  end

end
