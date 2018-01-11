Rails.application.routes.draw do

  namespace :diagnostician do
    resources :bookings, only: [ :index, :show, :new, :create, :update, :destroy] do
      member do
        get 'add_comment'
        get 'delete_comment'
      end
    end
    resources :diagnostics, only: [ :index, :show, :new, :create, :edit] do
      member do
        get 'add_plan'
        get 'delete_plan'
      end
    end
    resources :users, only: [:show, :index]
  end

  devise_for :users

  root to: 'pages#home'
  get '/eligibility', to: 'pages#eligibility'
  get '/valuation', to: 'pages#valuation'

  #inscription
  get '/disponibility', to: 'inscriptions#disponibility'
  get '/checkpoint', to: 'inscriptions#checkpoint'
  get '/confirmation', to: 'inscriptions#confirmation'

  resources :users, only: [:show]
  resources :answers
  # resources :bookings, only: [:create]
end
