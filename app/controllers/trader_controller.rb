class TraderController < ApplicationController
	protect_from_forgery :except => [:destroy, :create]
	@@sns_client ||= Aws::SNS::Client.new

	def index 
		@traders = Trader.all
	end

	def show
    	@trader = Trader.find(params[:id])
	end

	def new
	end

	def create
		@trader = Trader.new(trader_params)
		
		resp = @@sns_client.create_topic({
			name: @trader.name, # required
		})

		@trader.trader_arn = resp.topic_arn
		
		if @trader.save
			render :json => {:trader_id => @trader.id, :trader_arn => @trader.trader_arn}
		else
			render :json => {}
		end 
	end

	def destroy
		@trader = Trader.find(params[:id])
		resp = @@sns_client.delete_topic({
			topic_arn: @trader.trader_arn
		})
		if Trader.destroy(@trader.id)
			render :json => {:deleted => true}
		else
			render :json => {:deleted => false}
		end
	end

	def publish_message
		@trader = Trader.find(params[:id])
		@message = params[:message]
		resp = @@sns_client.publish({
			topic_arn: @trader.trader_arn,
			message: @message
		})
	end

	private
  	def trader_params
    	params.permit(:name)
  	end
end
