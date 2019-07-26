class CreateDevices < ActiveRecord::Migration[5.2]
  def change
    create_table :devices do |t|
    	t.string :device_token 
      t.timestamps
    end
  end
end
