Rails.application.routes.draw do
  get 'welcome/index'
  resources :articles
  root 'welcome#index'

  get 'subscription/index'
  root 'subscription#index'

  post 'subscription/create'
  root 'subscription#create'

  get 'subscription/new'
  root 'subscription#new'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
