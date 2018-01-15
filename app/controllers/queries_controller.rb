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
		if params[:id] == 'run_quick_query' || params[:id] == 'execute_quick_run'
			render 'quick_run'
		else
			query = Query.find(params[:id])
			@result_header, @result_values, @query_sql, @env = Query.execute_query(params[:environment_name], query.saved_query)
		end
	end

	def execute_quick_run		
		@result_header, @result_values, @query_sql, @env = Query.execute_query(params[:environment_name], params[:saved_query])
		render 'show'
	end

	def download
		result_header, result_values, query_sql, env = Query.execute_query(params[:environment_name], params[:saved_query])

		#Attachment name
		filename = "#{Time.now.strftime('%Y%m%d%H%M%S')}.xlsx"
		temp_file = Rails.root.join('tmp', filename)

		Axlsx::Package.new do |p|
			p.workbook.add_worksheet(:name => "Query Output") do |sheet|
				sheet.add_row result_header
				result_values.each do |res|					
					sheet.add_row res
				end
			end
			p.serialize(temp_file)
		end	

		send_file temp_file, :type => 'application/application/vnd.openxmlformats-officedocument.spreadsheetml.template', disposition: 'attachment', :filename => filename

	end

end
