class DeviceController < ApplicationController
	def create
		@device = Device.new
		@device.token = params[:token]

		if @device.save 
			render :json => {
				:token => @device.token 
			}
		else
			render :json => {}
		end
	end

	def new_endpoint
		platform = params[:platform]
		token = params[:token]

		if (Device.where(["device_token = ?", token])).exists?
			@device = Device.where(["device_token = ?", token])

		Aws.config.update({
			credentials: Aws::Credentials.new(ENV['AWSAccessKeyId'], ENV['AWSSecretKey']),
			region: ENV['AWSRegion']
		})
		sns_client ||= Aws::SNS::Client.new

		resp = sns_client.create_platform_endpoint({
		  platform_application_arn: "",
		  token: ""
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
