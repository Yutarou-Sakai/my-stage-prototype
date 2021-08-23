Rails.application.routes.draw do
  devise_for :users

  root 'home#index'

  resources :home, only: [:index]
  resources :users, only: [:index]
  resources :courses
  resources :activities, only: [:index]
end
