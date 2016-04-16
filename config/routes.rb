Rails.application.routes.draw do
  scope "(:locale)", locale: /en|ru/ do
    get '/:locale' => 'home#index'
    root 'dashboard/home#index'
    namespace :home do
      root "home#index"

      post "oauth/callback" => "oauths#callback"
      get "oauth/callback" => "oauths#callback" # for use with Github, Facebook
      get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
      get "login" => "user_sessions#new", :as => :login

      resources :users, only: [:new, :create]
      resources :user_sessions, only: [:new, :create]
    end

    namespace :dashboard do
      root "home#index"

      patch "/decks/:id" => "decks#activate", :as => :activate
      post "check" => "home#check"
      post "logout" => "user_sessions#destroy", :as => :logout

      resources :cards
      resources :users, only: [:edit, :update, :destroy]
      resources :user_sessions, only: :destroy
      resources :decks
    end
  end
end
