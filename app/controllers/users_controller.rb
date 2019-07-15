class UsersController < ApplicationController
  def index
      @users = User.all
  end

  def new
      @user = User.new
  end

  def create
      @user = User.new(user_params)
      if @user.save
          session[:user_id] = @user.id
          redirect_to @user, alert: "SUCCESS"
      else
          redirect_to new_user_path, alert: "ERROR"
      end
  end

  def show
    @user = User.find(params[:id])
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
