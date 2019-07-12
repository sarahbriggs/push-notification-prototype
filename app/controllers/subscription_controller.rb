class SubscriptionController < ApplicationController
	def index
	end

	def new
	end

	def create
		@traders = Trader.all
	end  
end
