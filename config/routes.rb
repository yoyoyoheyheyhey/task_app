Rails.application.routes.draw do
  resources :users
  resources :tasks
  resources :sessions, only: [:create, :destroy]
end
