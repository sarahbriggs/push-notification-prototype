class SubscriptionController < ApplicationController
	def index
	end

	def new
		@traders = Trader.all
	end

	def create
	end  
end
