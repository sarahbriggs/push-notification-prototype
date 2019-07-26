class PlatformApplicationController < ApplicationController
	protect_from_forgery :except => :create

	def new
		Aws.config.update({
			credentials: Aws::Credentials.new(ENV['AWSAccessKeyId'], ENV['AWSSecretKey']),
			region: ENV['AWSRegion']
		})
		sns_client ||= Aws::SNS::Client.new

        platform = params[:platform]
        platform_name = params[:platform_name]

  		platform_arn = 'arn:aws:sns:us-east-1:877941893971:app/APNS_SANDBOX/testPlatformApplication'

        @platform_application = PlatformApplication.new 
        @platform_application.platform_name = platform_name
        @platform_application.platform_arn = platform_arn

        if @platform_application.save
			render :json => {
				:platform_name => @platform_application.platform_name,
				:platform_arn => @platform_application.platform_arn
			}
		else
			render :json => {}
		end
	end 
end










