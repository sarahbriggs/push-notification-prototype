class CreateTraders < ActiveRecord::Migration[5.2]
  def change
    create_table :traders do |t|
    	t.string :name
    	t.string :trader_arn
      t.timestamps
    end
  end
end
