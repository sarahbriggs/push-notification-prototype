class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
    	t.belongs_to :user, index: true 
    	t.belongs_to :trader, index: true 

      t.timestamps
    end

    add_index "subscriptions", [:user.user_id, :trader.trader_id], 
    :name => "index_subscriptions_on_user_and_trader", :unique => true

    validates_uniqueness_of :user.user_id, :trader.trader_id
  end
end
