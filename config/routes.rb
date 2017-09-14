Rails.application.routes.draw do

  namespace :diagnostician do
    resources :bookings, only: [ :index, :new, :create, :destroy]
    resources :diagnostics, only: [ :index, :new, :create, :edit, :update]
  end

  devise_for :users
  root to: 'pages#home'
  get '/eligibility', to: 'pages#eligibility'


  resources :users, only: [:show]
  resources :bookings, only: [:new, :create, :destroy, :index]

end
