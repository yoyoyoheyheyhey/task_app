Rails.application.routes.draw do
  root to: 'session#new'
  namespace :admin do
    resources :users
  end
  resources :users
  resources :tasks
  resources :sessions, only: [:new,:create, :destroy]
end
