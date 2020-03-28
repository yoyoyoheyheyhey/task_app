Rails.application.routes.draw do
  root to: 'session#new'
  namespace :admin do
    resources :users
  end
  resources :users, only: [:new, :create, :show]
  resources :tasks
  resources :sessions, only: [:new,:create, :destroy]
end
