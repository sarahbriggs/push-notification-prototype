class Device < ApplicationRecord
	has_many :user_devices 
	has_many :users, through: :user_devices
end
