Rails.application.routes.draw do
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "events#index"

  resources :events
  resources :user, only: %i[show edit update]
end
