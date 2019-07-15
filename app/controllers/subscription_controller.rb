class SubscriptionController < ApplicationController
	def index
		@traders = Trader.all
		@subscriptions = Subscription.all
	end

	def new
		@traders = Trader.all
		@user = User.find(1)
		@subscription = Subscription.new
	end

	def create
		@user = params[:user]
		@trader = params[:trader]
		@subscription = User.find(@user).subscriptions.create()
		@subscription.save
		# @subscription.belongs_to()
		# @subscription.user_id = User.find(params[:user]).user_id
		# @subscription.trader_id = Trader.find(params[:trader]).trader_id
		# @subscription.save
	end 

end
