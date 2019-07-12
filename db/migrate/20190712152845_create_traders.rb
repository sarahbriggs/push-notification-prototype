class CreateTraders < ActiveRecord::Migration[5.2]
  def change
    create_table :traders do |t|
    	t.integer :trader_id
    	t.string :name
      t.timestamps
    end
  end
end
