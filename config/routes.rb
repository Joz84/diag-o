Rails.application.routes.draw do

  namespace :diagnostician do
    resources :bookings, only: [ :index, :show, :new, :create, :destroy]
    resources :diagnostics, only: [ :index, :new, :create, :edit, :update]
    resources :users, only: [:show, :index]
  end

  devise_for :users
  root to: 'pages#home'
  get '/eligibility', to: 'pages#eligibility'


  resources :users, only: [:show]
  resources :bookings, only: [ :show, :new, :create, :destroy, :index]

end
