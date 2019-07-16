class SubscriptionController < ApplicationController
	def index
		@subscriptions = Subscription.all
	end

	def new
		@traders = Trader.all
	end

	def create
		@user = session[:user_id]
		@trader = params[:trader]
		@subscription = User.find(@user).subscriptions.create()
		@subscription.trader_id = @trader
		if @subscription.save
          redirect_to action: 'index', alert: "SUCCESS"
      	else
          redirect_to action: 'new', alert: "ERROR"
      end
	end 

end
