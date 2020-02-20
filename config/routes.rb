Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  direct :homepage do "#{root_url}" end

  resources :home
  resources :friendships do
    member do
      post :accept_request
      post :unfriend
    end
    collection do
      get :pending_friends
      get :requests_sent
    end
  end
end
