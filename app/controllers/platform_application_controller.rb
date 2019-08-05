class PlatformApplicationController < ApplicationController
	protect_from_forgery :except => :create
	
	def new
        platform = params[:platform]
        platform_name = params[:platform_name]

  		platform_arn = ENV['AWSPlatformARN']

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










