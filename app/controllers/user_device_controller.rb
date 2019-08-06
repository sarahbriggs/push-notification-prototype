class UserDeviceController < ApplicationController
	protect_from_forgery :except => :create
	@@sns_client ||= Aws::SNS::Client.new

	def create
		token = params[:token]
		user_id = params[:user_id]
		platform = params[:platform]
		@user = User.find(user_id)

		@device = UserDevice.where("device_token = ? AND user_id = ?", token, user_id).first_or_create

		if platform.eql? "APNS"
			@platform_arn = ENV['APNS_ARN']
		elsif platform.eql? "APNS_SANDBOX"
			@platform_arn = ENV['APNS_SANDBOX_ARN']
		elsif platform.eql? "GCM" || "FCM"
			@platform_arn = ENV['GCM_ARN']
		end 

		resp = @@sns_client.create_platform_endpoint({
		  platform_application_arn: @platform_arn,
		  token: @device.device_token
		})
		puts "----------------------------"
		puts resp
		puts "----------------------------"

		@device.device_endpoint = resp.endpoint_arn
		if @device.save
			render :json => {
				:device_token => @device.device_token,
				:endpoint_arn => @device.device_endpoint
			}
		else
			render :json => {}
		end

		# create new device-subscription for all user, trader pairs  
		first_device = @user.user_devices.first 
		subscription_list = first_device.subscriptions

		for subscription in subscription_list.to_a do
			@trader = Trader.find(subscription.trader_id)
			@device_subscription = @user.subscriptions.create()
			@device_subscription.trader_id = @trader.id

			response = @@sns_client.subscribe({
				topic_arn: @trader.trader_arn,
				protocol: 'application',
				endpoint: @device.device_endpoint,
				return_subscription_arn: false
			})
			@device_subscription.subscription_arn = response.subscription_arn

			if @device_subscription.save
				render :json => {:subscription_arn => 
					@device_subscription.subscription_arn}
			else 
				render :json => {}
			end 
		end 
	end
end
