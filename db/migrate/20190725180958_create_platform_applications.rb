class CreatePlatformApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :platform_applications do |t|
    	t.string :platform_name 
    	t.string :platform_arn
      t.timestamps
    end
  end
end
