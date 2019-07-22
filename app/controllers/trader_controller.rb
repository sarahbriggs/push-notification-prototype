class TraderController < ApplicationController
	def index 
		@traders = Trader.all
	end
	def show
    	@trader = Trader.find(params[:id])
	end
end
