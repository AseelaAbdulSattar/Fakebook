Rails.application.routes.draw do
  
  devise_for :users
  root to: "home#index"
  direct :homepage do
    "http://localhost:3000/"
  end

  resources :friendships, :home
  
  #match "/friendships/id" => "friendships#cancel_request", :as => 'cancel_request', :via => [:get, :post]
  #get '/friendships', to: 'friendships#cancel_request'

  #get 'friendships/new'
  #get 'friendships/index'
  #get 'home/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
