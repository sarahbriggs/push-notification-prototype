class CreateUserDevices < ActiveRecord::Migration[5.2]
  def change
    create_table :user_devices do |t|
    	t.belongs_to :user
    	t.string :device_token 
    	t.string :endpoint_arn 
      t.timestamps
    end
  end
end