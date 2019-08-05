class Subscription < ApplicationRecord
	belongs_to :user_device 
	belongs_to :trader
end
