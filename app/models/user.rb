class User < ApplicationRecord
	has_many :user_devices
	has_many :subscriptions, through: :user_devices
end
