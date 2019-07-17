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
		if @subscription.save
		  sns_client ||= Aws::SNS::Client.new
		  topic = 'arn:aws:sns:us-east-2:877941893971:snsTest'

		  sub_arn = sns_client.subscribe({
		  	topic_arn: topic,
		  	protocol: 'email',
		  	endpoint: User.find(@user).email,
		  	return_subscription_arn: true
		  }).subscription_arn
		  # @subscription.subscription_arn = @sub_arn
          redirect_to action: 'show', alert: "SUCCESS"
      	else
          redirect_to action: 'new', alert: "ERROR"
      end
	end 

	def destroy 
		@user = session[:user_id]
		@trader = params[:trader]
		sns_client ||= Aws::SNS::Client.new
		@sub_id = Subscription.find_by(user_id: @user, trader_id: @trader)

		if Subscription.destroy(@sub_id.id)
			# unsubscribe here ... need SubscriptionArn
			sns_client ||= Aws::SNS::Client.new
			resp = sns_client.list_subscriptions_by_topic({
				topic_arn: "arn:aws:sns:us-east-2:877941893971:snsTest"})

			@user_email = User.find(session[:user_id]).email
			@subscriber_arn = "test"
			resp.subscriptions.each do |subscription| 
				arn = subscription.subscription_arn
				endpoint = subscription.endpoint
				if endpoint == @user_email
					@subscriber_arn = arn
					break 
				end 
			end
			# this doesn't work
			
			sns_client.unsubscribe({
				subscription_arn: @subscriber_arn
			})

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






