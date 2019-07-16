class SubscriptionController < ApplicationController
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

		  sns_client.subscribe({
		  	topic_arn: topic,
		  	protocol: 'email',
		  	endpoint: User.find(@user).email
		  })

          redirect_to action: 'index', alert: "SUCCESS"
      	else
          redirect_to action: 'new', alert: "ERROR"
      end
	end 

	def destroy 
		@user = session[:user_id]
		@trader = params[:trader]
		@sub_id = Subscription.find_by(user_id: @user, trader_id: @trader)
		if Subscription.destroy(@sub_id.id)
			sns_client ||= Aws::SNS::Client.new

			# unsubscribe here ... need SubscriptionArn 
			
			redirect_to action: 'index', alert: "SUCCESS"
		else
          	redirect_to action: 'new', alert: "ERROR"
      end
	end 

end






