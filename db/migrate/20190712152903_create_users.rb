class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
    	t.string :name
    	t.string :email
      	t.timestamps
    end

    add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  end
end
