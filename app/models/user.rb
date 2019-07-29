class User < ApplicationRecord
	has_many :subscriptions
	has_many :traders, through: :subscriptions
	has_many :user_devices
end
