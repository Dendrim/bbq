Rails.application.routes.draw do
  resources :photos
  resources :subscriptions
  resources :comments
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "events#index"

  devise_for :users
  resources :users

  resources :events do
    resources :comments, only: %i[create destroy]
    resources :photos, only: %i[create destroy]
    resources :subscriptions, only: %i[create destroy]
  end

  resources :user, only: %i[show edit update]
end
