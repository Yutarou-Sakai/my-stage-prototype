Rails.application.routes.draw do
  devise_for :users
  
  root 'home#index'
  
  resources :home, only: [:index]
  resources :activities, only: [:index]
  
  resources :users, only: [:index, :show, :edit, :update] do
    resources :enrollments
  end
  resources :courses do
    resources :lessons
  end
end
