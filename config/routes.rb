Rails.application.routes.draw do
  resources :queries, :users
  root 'queries#index'

  get 	'queries/run_quick_query', 		to: 'queries#quick_run', 					as: 'quick_run'
  post 	'queries/execute_quick_run'		=> 	'queries#execute_quick_run', 	as: 'execute_quick_run'
end
