Rails.application.routes.draw do
  get 'welcome/index'
  resources :articles
  root 'welcome#index'

  get '/welcome' => 'welcome#index'

  get 'subscription/index'
  root 'subscription#index'

  post 'subscription/create'
  root 'subscription#create'

  get 'subscription/new'
  root 'subscription#new'

  get 'users/index'
  get 'users/new'
  get 'users/create'
  get 'users/show'
  resources :users

  get '/login' => 'sessions#new'  
  post '/login' => 'sessions#create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
