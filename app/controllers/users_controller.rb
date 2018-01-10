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

end
