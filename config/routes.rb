Rails.application.routes.draw do
  root to: 'session#new'
  resources :users
  resources :tasks
  resources :sessions, only: [:new,:create, :destroy]
end
