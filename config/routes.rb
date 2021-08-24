Rails.application.routes.draw do
  resources :lessons
  devise_for :users

  root 'home#index'

  resources :home, only: [:index]
  resources :users, only: [:index, :show, :edit, :update]
  resources :courses
  resources :activities, only: [:index]
end
