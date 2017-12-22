class CreateQueries < ActiveRecord::Migration[5.1]
  def change
    create_table :queries do |t|
    	t.text 		:saved_query
    	t.string	:user_name
      t.timestamps
    end
  end
end
