class SubscriptionController < ApplicationController
	# before_action :require_user, only: [:new, :show]
	protect_from_forgery :except => :create

	@@sns_client ||= Aws::SNS::Client.new
	

	def index
		@user = User.find(params[:id])
		@device = @user.user_devices.first
		@subscriptions = @device.subscriptions
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
			puts "------------------------------------"
			puts dev.device_endpoint
			puts "------------------------------------"
			# subscribe all user devices 
			resp = @@sns_client.subscribe({
				topic_arn: @trader.trader_arn,
				protocol: 'application',
				endpoint: dev.device_endpoint,
				return_subscription_arn: false
			})

			@subscription.subscription_arn = resp.subscription_arn
			@subscription.save
		end 
		render :json => {:created => true}
	end

	def destroy 
		@user = User.find(params[:user_id])
		@trader = Trader.find(params[:trader_id])

		devices_list = @user.user_devices
		for dev in devices_list.to_a do 
			@sub = Subscription.where(:trader_id => @trader.id, :user_device_id => dev.id).first
			puts "-------------"
			puts @sub.trader_id
			puts "-------------"
			@sub_arn = @sub.subscription_arn

			if Subscription.destroy(@sub.id)
				if @sub_arn != nil and @sub_arn != "pending confirmation"
					# unsubscribe here ... need SubscriptionArn
					@@sns_client.unsubscribe({
						subscription_arn: @sub_arn
					})
				end 
	        end
		end
		render :json => {:deleted => true}
	end

	def show
		@user = session[:user_id]
		@subscriptions = User.find(@user).subscriptions
	end

end






