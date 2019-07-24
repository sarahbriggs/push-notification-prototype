class SessionsController < ApplicationController
	protect_from_forgery :except => :create

	def new
	end

	def create
	  @user = User.find_by_email(params[:email])
	  if @user
	    session[:user_id] = @user.id
	    redirect_to '/'
	  else
	    redirect_to action: 'new'
	  end 
	  # if @user
	  # 	render :json => {:user_id => @user.id}
	  # else
	  # 	render :json => {}
	  # end
	end 

	def destroy
		session[:user_id] = nil
		redirect_to action: 'new'
	end
end
