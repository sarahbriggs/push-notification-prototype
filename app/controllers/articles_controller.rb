class ArticlesController < ApplicationController
	def new 
	end

	def create
		Aws.config.update({
        	credentials: Aws::Credentials.new('', ''), 
        	region: 'us-east-2'})
	    sns_client ||= Aws::SNS::Client.new
	    topic = 'arn:aws:sns:us-east-2:877941893971:snsTest'
	    sns_client.publish({
	    	topic_arn: topic,
	        message: params[:article].inspect
	    })
	end 
end
