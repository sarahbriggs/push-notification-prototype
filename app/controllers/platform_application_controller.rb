class PlatformApplicationController < ApplicationController
	protect_from_forgery :except => :create

	def new
		Aws.config.update({
			credentials: Aws::Credentials.new(ENV['AWSAccessKeyId'], ENV['AWSSecretKey']),
			region: 'us-east-1'
		})
		sns_client ||= Aws::SNS::Client.new

		# resp = sns_client.get_platform_application_attributes({
		# 	platform_application_arn: 'arn:aws:sns:us-east-1:877941893971:app/APNS_SANDBOX/testPlatformApplication'
		# })

		# render :json => {
		# 	:data => resp.data,
		# 	:attributes => resp.attributes
		# }

        platform = params[:platform]
        platform_name = params[:platform_name]
        
		if ['APNS', 'APNS_SANDBOX'].include?(platform)
			# file = File.read(apns_private_key_path)
   #        	p12 = OpenSSL::PKCS12.new(file, apns_private_key_password)
   #        	cert = p12.certificate

          	attributes = {
            'PlatformCredential': ENV['APNS_PRIVATE_KEY'],
            'PlatformPrincipal': ENV['APNS_CERT']
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










