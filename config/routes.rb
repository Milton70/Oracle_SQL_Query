Rails.application.routes.draw do
  resources :queries
  root 'queries#index'
end
