Rails.application.routes.draw do
  root to: 'tasks#index'
  resources :users
  resources :tasks
  resources :sessions, only: [:new,:create, :destroy]
end
