Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/eligibility', to: 'pages#eligibility'

  resources :bookings, only: [:new, :create, :index]

end
