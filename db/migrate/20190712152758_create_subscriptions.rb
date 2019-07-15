class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
    	t.belongs_to :user, index: true 
    	t.belongs_to :trader, index: true 
   
      t.timestamps
    end
  end
end
