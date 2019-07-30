class CreateUserDevices < ActiveRecord::Migration[5.2]
  def change
    create_table :user_devices do |t|
    	t.belongs_to :user
    	t.string :device_token 
    	t.string :device_endpoint 
      t.timestamps
    end
  end
end