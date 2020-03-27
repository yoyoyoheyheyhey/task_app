Rails.application.routes.draw do
  resources :users
  resources :tasks
  resources :sessions, only: [:new,:create, :destroy]
end
