class LinkUserToQuery < ActiveRecord::Migration[5.1]
  def change
  	add_reference :queries, :user, index: true
  	remove_column :queries, :user_name
  end
end
