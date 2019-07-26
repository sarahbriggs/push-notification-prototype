class User < ApplicationRecord
	has_many :subscriptions
	has_many :traders, through: :subscriptions
	has_many :user_devices 
	has_many :devices, through: :user_devices
end
