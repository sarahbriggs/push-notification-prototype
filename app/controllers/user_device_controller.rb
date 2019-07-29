class UserDeviceController < ApplicationController
	protect_from_forgery :except => :create

	def create
		token = params[:token]
		user_id = params[:user_id]
		platform = params[:platform]
		
		@device = UserDevice.where("device_token = ? AND user_id = ?", token, user_id)
		if !(@device.exists?)
			@user = User.find(params[:user_id])
			@device = @user.user_devices.create()
			@device.device_token = token
		end
		
		@platform_application = PlatformApplication.where("platform_name = ?", platform)

		Aws.config.update({
			credentials: Aws::Credentials.new(ENV['AWSAccessKeyId'], ENV['AWSSecretKey']),
			region: ENV['AWSRegion']
		})
		sns_client ||= Aws::SNS::Client.new

		resp = sns_client.create_platform_endpoint({
		  platform_application_arn: @platform_application.platform_arn,
		  token: @device.device_token
		})

		@device.endpoint_arn = resp.endpoint_arn
		if @device.save
			render :json => {
				:device_token => @device.device_token,
				:endpoint_arn => @device.endpoint_arn
			}
		else
			render :json => {}
		end
	end
end
