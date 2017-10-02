Rails.application.routes.draw do

  namespace :diagnostician do
    resources :bookings, only: [ :index, :show, :new, :create, :update, :destroy]
    resources :diagnostics, only: [ :index, :show, :new, :create, :edit]
    resources :users, only: [:show, :index]
  end

  devise_for :users
  root to: 'pages#home'
  get '/eligibility', to: 'pages#eligibility'
  get '/disponibility', to: 'inscriptions#disponibility'
  get '/checkpoint', to: 'inscriptions#checkpoint'
  get '/confirmation', to: 'inscriptions#confirmation'
  get "diagnostician/diagnostic/:id/add_plan", to: "diagnostician/diagnostics#add_plan", as: "add_plan"
  get "diagnostician/diagnostic/:id/delete_plan", to: "diagnostician/diagnostics#delete_plan", as: "delete_plan"

  resources :users, only: [:show]
  resources :bookings, only: [:new, :create, :show, :destroy, :index, :update]



end
