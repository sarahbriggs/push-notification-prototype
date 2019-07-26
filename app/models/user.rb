class User < ApplicationRecord
	has_and_belongs_to_many :devices 
	has_many :subscriptions
	has_many :traders, through: :subscriptions
end
