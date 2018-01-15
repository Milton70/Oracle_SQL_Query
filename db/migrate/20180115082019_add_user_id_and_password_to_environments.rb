class AddUserIdAndPasswordToEnvironments < ActiveRecord::Migration[5.1]
  def change
  	add_column :environments, :db_user_id, :string
  	add_column :environments, :db_pwd, :string
  end
end
