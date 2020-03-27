Rails.application.routes.draw do
  get 'users/new'
  get 'users/show'
  get 'users/edit'
  get 'users/index'
  root to: 'tasks#index'
  resources :tasks
end
