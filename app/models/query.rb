class Query < ApplicationRecord
	belongs_to :user

	validates :query_name, presence: true, uniqueness: true
	validates :query_description, presence: true
	validates :saved_query, presence: true
	validates :user_id, presence: true

	def execute_query(the_query)
	end
	
end
