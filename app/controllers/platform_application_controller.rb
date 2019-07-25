class PlatformApplicationController < ApplicationController
	def new
        platform = params[:platform]
        platform_name = params[:platform_name]
        
       	apns_private_key_path = params[:apns_private_key_path]
        apns_private_key_password = params[:apns_private_key_password]
        
        Aws.config.update({
			credentials: Aws::Credentials.new(ENV['AWSAccessKeyId'], ENV['AWSSecretKey']),
			region: 'us-east-2'
		})
		sns_client ||= Aws::SNS::Client.new

		if ['APNS', 'APNS_SANDBOX'].include?(platform)
			file = File.read(apns_private_key_path)
          	p12 = OpenSSL::PKCS12.new(file, platform_apns_private_key_password)
          	cert = p12.certificate
          	
          	attributes = {
            'PlatformCredential': p12.key.to_s,
            'PlatformPrincipal': cert.to_s 
        	}
        end

        resp = sns_client.create_platform_application({
            name: platform_name,
            platform: platform,
            attributes: attributes,
        })
        platform_arn = resp.platform_application_arn

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










