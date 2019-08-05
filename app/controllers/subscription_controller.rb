class SubscriptionController < ApplicationController
	# before_action :require_user, only: [:new, :show]
	protect_from_forgery :except => :create

	@@sns_client ||= Aws::SNS::Client.new
	

	def index
		@subscriptions = User.find(params[:id]).subscriptions
	end

	def new
		@traders = Trader.all
		@user = session[:user_id]
	end

	def create
		user_id = params[:user_id]
		trader_id = params[:trader_id]

      	@user = User.find(user_id)
		@trader = Trader.find(trader_id)
		
		devices_list = @user.user_devices
		for dev in devices_list.to_a do 
			@subscription = Subscription.where(:trader_id => 
			trader_id, :user_device_id => dev.id).first_or_create

			# subscribe all user devices 
			resp = @@sns_client.subscribe({
				topic_arn: @trader.trader_arn,
				protocol: 'application',
				endpoint: dev.device_endpoint,
				return_subscription_arn: false
			})

			@subscription.subscription_arn = resp.subscription_arn
			if @subscription.save
				render :json => {:subscription_arn => @subscription.subscription_arn}
		    else
		        render :json => {}
		    end
		end 
	end

	def destroy 
		@user = session[:user_id]
		@trader = params[:trader]

		devices_list = @user.user_devices
		for dev in devices_list.to_a do 
			@sub = Subscription.find_by(user_device_id: dev.id, trader_id: @trader)
			@sub_arn = @sub.subscription_arn

			if Subscription.destroy(@sub.id)
				if @sub_arn != nil and @sub_arn != "pending confirmation"
					# unsubscribe here ... need SubscriptionArn
					@@sns_client.unsubscribe({
						subscription_arn: @sub_arn
					})
				end 
				redirect_to action: 'index', alert: "SUCCESS"
			else
	          	redirect_to action: 'new', alert: "ERROR"
	        end
		end 
	end

	def show
		@user = session[:user_id]
		@subscriptions = User.find(@user).subscriptions
	end

end






