json.extract! subscription, :id, :user_id, :trader_id, :created_at
json.url subscription_url(subscription, format: :json)