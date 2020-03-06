Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  root to: "home#index"
  direct :homepage do "#{root_url}" end

  resources :home, :posts
  resources :posts do
    member do
      patch :destroy_post
    end
    collection do
      get :other_post
    end
  end
  resources :friendships do
    member do
      post :accept_request
      post :unfriend
      post :cancel_request
      patch :accept_or_reject_request
    end
    collection do
      get :requests_received
      get :requests_sent
    end
  end
end
