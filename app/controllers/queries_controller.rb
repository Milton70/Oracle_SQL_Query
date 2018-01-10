class QueriesController < ApplicationController

	def index
		@queries = Query.all
	end

	def new
		@query = Query.new
	end

	def create		
		@query = Query.new
		@query.query_name 				= params['query']['query_name']
		@query.query_description 	= params['query']['query_description']
		@query.saved_query 				= params['query']['saved_query']
		@query.user_id 						= params['query']['user_id'] 
		if @query.save
			flash[:success] = "Query [ #{@query.query_name} ] created for User [ #{User.find(@query.user_id).user_name} ]."
			redirect_to '/queries'
		else
			render 'new'
		end		
	end

	def edit
		@query = Query.find(params[:id])
		@error_query = @query
	end

	def update
		@query = Query.find(params[:id])
		if @query.update query_name: params['query']['query_name'], query_description: params['query']['query_description'], saved_query: params['query']['saved_query'], user_id: params['query']['user_id']
			flash[:success] = "Query [ #{@query.query_name} ] updated."
			redirect_to '/queries'
		else
			@error_query = @query
			@query = Query.find(params[:id])
			render 'edit'
		end
	end

	def destroy
		@query = Query.find(params[:id])
		@query.destroy
		redirect_to action: :index
	end

	def show
byebug		
		@query = Query.find(params[:id])
		@results = Query.execute_query(@query.saved_query)
byebug
	end

end
