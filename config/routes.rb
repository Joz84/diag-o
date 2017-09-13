Rails.application.routes.draw do

  devise_for :users
  root to: 'pages#home'
  get '/eligibility', to: 'pages#eligibility'


  resources :users, only: [:show]
  resources :bookings, only: [:new, :create, :destroy, :index]

end
