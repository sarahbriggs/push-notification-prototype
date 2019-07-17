class SubscriptionController < ApplicationController
	before_action :require_user, only: [:new, :show]
	def index
		@subscriptions = Subscription.all
	end

	def new
		@traders = Trader.all
		@user = session[:user_id]
	end

	def create
		@user = session[:user_id]
		@trader = params[:trader]
		@subscription = User.find(@user).subscriptions.create()
		@subscription.trader_id = @trader
		
		sns_client ||= Aws::SNS::Client.new
		topic = 'arn:aws:sns:us-east-2:877941893971:snsTest'
		resp = sns_client.subscribe({
		  topic_arn: topic,
		  protocol: 'email',
		  endpoint: User.find(@user).email,
		  return_subscription_arn: false
		})
		@subscription.subscription_arn = resp.subscription_arn

		if @subscription.save
          redirect_to action: 'show', alert: "SUCCESS"
      	else
          redirect_to action: 'new', alert: "ERROR"
      end
	end 

	def destroy 
		@user = session[:user_id]
		@trader = params[:trader]
		sns_client ||= Aws::SNS::Client.new
		@sub = Subscription.find_by(user_id: @user, trader_id: @trader)
		@sub_arn = @sub.subscription_arn

		if Subscription.destroy(@sub.id)
			if @sub_arn != nil and @sub_arn != "pending confirmation"
				# unsubscribe here ... need SubscriptionArn
				sns_client ||= Aws::SNS::Client.new
				resp = sns_client.list_subscriptions_by_topic({
					topic_arn: "arn:aws:sns:us-east-2:877941893971:snsTest"})
				sns_client.unsubscribe({
					subscription_arn: @sub_arn
				})
			end 
			redirect_to action: 'index', alert: "SUCCESS"
		else
          	redirect_to action: 'new', alert: "ERROR"
      end
	end

	def show
		@user = session[:user_id]
		@subscriptions = User.find(@user).subscriptions
	end

end






