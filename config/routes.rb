Rails.application.routes.draw do
  get '/welcome' => 'welcome#index'
  root 'welcome#index'

  get 'subscription/index'
  post 'subscription/create'
  get 'subscribe' => 'subscription#new'

  get 'users/index'
  get 'users/new'
  get 'users/create'
  get 'users/show'
  resources :users

  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'  
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
