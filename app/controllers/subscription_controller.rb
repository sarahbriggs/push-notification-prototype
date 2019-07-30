class SubscriptionController < ApplicationController
	# before_action :require_user, only: [:new, :show]
	protect_from_forgery :except => :create
	
	def index
		@subscriptions = User.find(params[:id]).subscriptions
	end

	def new
		@traders = Trader.all
		@user = session[:user_id]
	end

	def create
      	@user = User.find(params[:user_id])
		@trader = Trader.find(params[:trader_id])

		@subscription = @user.subscriptions.create()
		@subscription.trader_id = @trader.id

		Aws.config.update({
          credentials: Aws::Credentials.new(ENV['AWSAccessKeyId'], ENV['AWSSecretKey']),
          region: ENV['AWSRegion']})
		sns_client ||= Aws::SNS::Client.new

		devices_list = @user.first.user_devices
		
		for dev in devices_list.to_a do 
			puts "---- endpoint ----"
			puts dev.device_endpoint 
			puts "-----------------"
			resp = sns_client.subscribe({
				topic_arn: @trader.trader_arn,
				protocol: 'application',
				endpoint: dev.device_endpoint,
				return_subscription_arn: false
			})

			@subscription.subscription_arn = resp.subscription_arn
			if @subscription.save
				render :json => {:subscription_arn => @subscription.subscription_arn}
      		else
          		render :json => {}
      		end
      	end 
	end

	def destroy 
		@user = session[:user_id]
		@trader = params[:trader]
		Aws.config.update({
          credentials: Aws::Credentials.new(ENV['AWSAccessKeyId'], ENV['AWSSecretKey']),
          region: ENV['AWSRegion']})
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






