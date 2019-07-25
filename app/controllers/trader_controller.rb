class TraderController < ApplicationController
	protect_from_forgery :except => :create

	def index 
		@traders = Trader.all
	end

	def show
    	@trader = Trader.find(params[:id])
	end

	def new
	end

	def create
		@trader = Trader.new 
		@trader.name = params[:name]

		puts @trader.name

		Aws.config.update({
			credentials: Aws::Credentials.new(ENV['AWSAccessKeyId'], ENV['AWSSecretKey']),
			region: 'us-east-2'})
		
		sns_client ||= Aws::SNS::Client.new
		resp = sns_client.create_topic({
			name: @trader.name, # required
			tags: [
				{
					key: trader_name, # required
					value: @trader.name, # required
				},
			]
		})

		@trader.trader_arn = resp.topic_arn
		if @trader.save
			render :json => {:trader_id => @trader.id}
		else
			render :json => {}
		end 
	end 
end
