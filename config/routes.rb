Rails.application.routes.draw do

  devise_for :users
  root to: 'pages#home'
  get '/eligibility', to: 'pages#eligibility'


  resources :users, only: [:index, :show] do
    resources :bookings, only: [:new, :create]
  end

  namespace :my do
    resources :bookings, only: [:index]
  end

end
