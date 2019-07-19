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
      @user.save!
      # if @user.save
      #     session[:user_id] = @user.id
      #     redirect_to @user, alert: "SUCCESS"
      # else
      #     redirect_to action: 'new', alert: "ERROR"
      # end
  end

  def show
    @user = User.find(params[:id])
  end

  private
  def user_params
    params.require(:user).permit(:name, :email)
  end
end
