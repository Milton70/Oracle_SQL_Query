class User < ApplicationRecord
	has_many :queries

	validates :user_name, presence: true, uniqueness: true
	
end
