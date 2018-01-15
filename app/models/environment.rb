class Environment < ApplicationRecord

	validates :environment_name, presence: true, uniqueness: true
	validates :db_pwd, presence: true
	validates :db_user_id, presence: true

end
