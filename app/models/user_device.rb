class UserDevice < ApplicationRecord
	has_many :subscriptions
	has_many :traders, through: :subscriptions
	belongs_to :user
end