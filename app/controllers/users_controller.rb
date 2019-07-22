class UsersController < ApplicationController
  # before_action :require_user, only: [:index, :show]
  protect_from_forgery :except => :create
  def index
      @users = User.all
  end

  def new
      @user = User.new
  end

  def create
      @user = User.new(user_params)
      if @user.save
        render :json => {:user_id => @user.id}
      else
        render :json => {}
      end
  end

  def show
    @user = User.find(params[:id])
  end

  private
  def user_params
    params.require(:user).permit(:name, :email)
  end
end
