Rails.application.routes.draw do
  namespace :admin do
    resources :tasks
  end
  root to: 'sessions#new'
  get '/login', to: "sessions#new"
  namespace :admin do
    resources :users
  end
  resources :users, only: [:new, :create, :show]
  resources :tasks
  resources :sessions, only: [:new,:create, :destroy] 
end
