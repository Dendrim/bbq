Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "events#index"

  devise_for :users
  resources :users

  resources :events
  resources :user, only: %i[show edit update]
end
