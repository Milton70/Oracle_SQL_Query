Rails.application.routes.draw do
  resources :queries, :users
  root 'queries#index'
end
