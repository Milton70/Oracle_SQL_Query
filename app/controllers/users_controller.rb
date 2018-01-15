class UsersController < ApplicationController

	def index
		@users = User.all
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new
		@user.user_name = params['user']['user_name']
		if @user.save
			flash[:success] = "User [ #{@user.user_name} ] created."
			redirect_to '/users'
		else
			render 'new'
		end		
	end

	def edit
		@user = User.find(params[:id])
		@error_user = @user
	end

	def update
		@user = User.find(params[:id])
		if @user.update user_name: params['user']['user_name']
			flash[:success] = "User [ #{@user.user_name} ] updated."
			redirect_to '/users'
		else
			@error_user = @user
			@user = User.find(params[:id])
			render 'edit'
		end
	end

	def destroy		
		@user = User.find(params[:id])
		@user.destroy
		redirect_to action: :index
	end

	def db_config
		@envs = Environment.all		
	end

	def new_db
		@env = Environment.new		
	end

	def create_db
		@env = Environment.new	
		@env.environment_name = params['environment']['environment_name']
		@env.db_user_id 			= params['environment']['db_user_id']
		@env.db_pwd 					= params['environment']['db_pwd']
		if @env.save
			flash[:success] = "Environment [ #{@env.environment_name} ] created."
			redirect_to '/db_config'
		else
			render 'new_db'
		end		
	end

	def edit_db
		@env = Environment.find(params[:id])
		@error_env = @env
	end		

	def update_db
		@env = Environment.find(params[:id])
		if @env.update environment_name: params['environment']['environment_name'], db_user_id: params['environment']['db_user_id'], db_pwd: params['environment']['db_pwd']
			flash[:success] = "Environment [ #{@env.environment_name} ] updated."
			redirect_to '/db_config'
		else
			@error_env = @env
			@env = Environment.find(params[:id])
			render 'edit_db'
		end
	end

	def delete_db
		@env = Environment.find(params[:id])
		@env.destroy
		redirect_to action: :db_config				
	end

end
