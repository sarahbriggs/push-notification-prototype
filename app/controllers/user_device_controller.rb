class UserDeviceController < ApplicationController
	protect_from_forgery :except => :create

	def create
		token = params[:token]
		user_id = params[:user_id]
		platform = params[:platform]
		@user = User.find(user_id)

		@dev = UserDevice.where("device_token = ? AND user_id = ?", token, user_id)
		if !(@dev.exists?)
			@device = @user.user_devices.create()
			@device.device_token = token
		else
			@device = @dev.first 
		end

		@platform_application = PlatformApplication.where("platform_name = ?", platform)
			
		Aws.config.update({
			credentials: Aws::Credentials.new(ENV['AWSAccessKeyId'], ENV['AWSSecretKey']),
			region: ENV['AWSRegion']
		})
		sns_client ||= Aws::SNS::Client.new

		resp = sns_client.create_platform_endpoint({
		  platform_application_arn: @platform_application.first.platform_arn,
		  token: @device.device_token
		})
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
		subscription_list = @user.subscriptions
		for subscription in subscription_list.to_a do
			@trader = Trader.find(subscription.trader_id)
			@device_subscription = @user.subscriptions.create()
			@device_subscription.trader_id = @trader.id

			response = sns_client.subscribe({
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
