Rails.application.routes.draw do
  resources :queries, :users
  root 'queries#index'

  get 		'db_config',									to: 'users#db_config', 						as: 'users_db'
  get 		'new_db',											to: 'users#new_db',								as: 'new_db'
  post 		'create_db'										=> 	'users#create_db',						as: 'create_db'
  get 		'edit_db/:id',								to: 'users#edit_db',							as: 'edit_db'
  post 		'update_db/:id'								=> 	'users#update_db',						as: 'update_db'
  delete 	'delete_db/:id',							to: 'users#delete_db',						as: 'delete_db'
  get 		'queries/run_quick_query', 		to: 'queries#quick_run', 					as: 'quick_run'
  post 		'queries/execute_quick_run'		=> 'queries#execute_quick_run', 	as: 'execute_quick_run'
  get 		'download_csv',								to: 'queries#download', 					as: 'download_csv'
end
