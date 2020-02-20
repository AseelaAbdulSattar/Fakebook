Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  direct :homepage do "#{root_url}" end

  resources :home
  resources :friendships do
    member do
      post :accept_request
      post :unfriend
      post :cancel_request
    end
    collection do
      get :friend_requests
      get :pending_friends
    end
  end
end
