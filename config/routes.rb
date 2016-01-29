Rails.application.routes.draw do
  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback" # for use with Github, Facebook
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider

  root "home#index"
  post "check" => "cards#check"
  resources :cards
  resources :users
  resources :user_sessions

  get "login" => "user_sessions#new", :as => :login
  post "logout" => "user_sessions#destroy", :as => :logout
end
