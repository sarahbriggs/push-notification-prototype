class SessionsController < ApplicationController
	def new
	end

	def create
	  @user = User.find_by_email(params[:session][:email])
	  if @user
	    session[:user_id] = @user.id
	    redirect_to '/'
	  else
	    redirect_to action: 'new'

	  end 
	end 

	def destroy
		session[:user_id] = nil
		redirect_to action: 'new'
	end
end
