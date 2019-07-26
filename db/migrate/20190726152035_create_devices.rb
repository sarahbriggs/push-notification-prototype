class CreateDevices < ActiveRecord::Migration[5.2]
  def change
    create_table :devices do |t|
    	t.string :device_token 
      t.timestamps
    end

    create_table :user_devices do |t|
    	t.belongs_to :user
    	t.belongs_to :device
      t.timestamps
    end 
  end
end
