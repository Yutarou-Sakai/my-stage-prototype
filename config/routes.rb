Rails.application.routes.draw do
  resources :courses
  root 'static_pages#index'
end
