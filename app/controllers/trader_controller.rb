class TraderController < ApplicationController
	def index 
		@traders = Trader.all
	end

	def show
    	@trader = Trader.find(params[:id])
	end

	def new
		@trader = Trader.new 
		@trader.name = "Carolyn"
		@trader.trader_arn = "aws::####::abc::test"
	end

	def create
		@trader = Trader.new(trader_params)
		if @trader.save
			render :json => {:trader_id => @trader.id}
		else
			render :json => {}
		end 
	end 
end
