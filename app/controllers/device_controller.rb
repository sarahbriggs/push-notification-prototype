class DeviceController < ApplicationController
	def create
		@device = Device.new
		@device.token = params[:token]
		
		if @device.save 
			render :json => {
				:token => @device.token 
			}
		else
			render :json => {}
		end
	end 
end
