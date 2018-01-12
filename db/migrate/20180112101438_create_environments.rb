class CreateEnvironments < ActiveRecord::Migration[5.1]
  def change
    create_table :environments do |t|
    	t.string :environment_name
      t.timestamps
    end
  end
end
