class TraderController < ApplicationController
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

		sns_client ||= Aws::SNS::Client.new
		resp = sns_client.create_topic({
			name: , # required
			tags: [
				{
					key: @trader.name, # required
					value: "", # required
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
