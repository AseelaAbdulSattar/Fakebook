Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  direct :homepage do
    "http://localhost:3000/"
  end

  resources :home
  resources :friendships do
    member do
      match :accept_request, :via => [:post]
      match :unfriend, :via => [:post]
    end
    collection do
      match :pending_friends, :via => [:get]
      match :requests_sent, :via => [:get]
    end
  end
end
