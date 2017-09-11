Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/eligibility', to: 'pages#eligibility'
  get 'calendars/new', to: 'calendars#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
