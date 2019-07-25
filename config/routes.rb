Rails.application.routes.draw do
  get '/welcome' => 'welcome#index'
  root 'welcome#index'

  get 'subscription/index'
  post 'subscription/create'
  get 'subscribe' => 'subscription#new'
  delete '/subscription' => 'subscription#destroy'
  get 'my_subscriptions' => 'subscription#show'
  resources :subscription

  get 'users/index'
  get 'users/new'
  get 'users/create'
  get 'users/show'
  resources :users

  get 'signup' => 'users#new'
  post 'signup' => 'users#index'
  get 'login' => 'sessions#new'  
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  resources :sessions

  get 'trader/index'
  get 'trader/new' => 'trader#new'
  post 'trader/new' => 'trader#create'
  resources :trader

  post 'platform/new' => 'platform_application#new'
  resources :platform_application
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
