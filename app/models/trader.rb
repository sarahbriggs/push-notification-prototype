class Trader < ApplicationRecord
	has_many :subscriptions 
	has_many :user_devices, through: :subscriptions
end
