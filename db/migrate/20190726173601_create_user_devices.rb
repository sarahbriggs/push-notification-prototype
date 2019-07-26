class CreateUserDevices < ActiveRecord::Migration[5.2]
  def change
    create_table :user_devices do |t|
    	t.belongs_to :user
    	t.belongs_to :device 
      t.timestamps
    end
  end
end
