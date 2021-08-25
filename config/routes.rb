Rails.application.routes.draw do
  devise_for :users
  
  root 'home#index'
  
  resources :home, only: [:index]
  resources :users, only: [:index, :show, :edit, :update]
  resources :activities, only: [:index]
  
  resources :courses do
    resources :lessons
  end
end
