class TraderController < ApplicationController
	def index 
		@traders = Trader.all
	end 
end
