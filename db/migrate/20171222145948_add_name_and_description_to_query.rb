class AddNameAndDescriptionToQuery < ActiveRecord::Migration[5.1]
  def change
  	add_column :queries, :query_name, :string
  	add_column :queries, :query_description, :string
  end
end
