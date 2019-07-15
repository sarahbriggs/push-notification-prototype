class SubscriptionController < ApplicationController
	def index
	end

	def new
		@traders = Trader.all
		@user = User.find(1)
	end

	def create
		@trader = Trader.find(params[:trader])
		@user = User.find(params[:user])
	end  
end
