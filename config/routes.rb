Rails.application.routes.draw do
  scope "(:locale)", locale: /en|ru/ do
    get '/:locale' => 'home#index'
    root 'dashboard/home#index'
    post "oauth/callback" => "home/oauths#callback"
    get "oauth/callback" => "home/oauths#callback"
    get "oauth/:provider" => "home/oauths#oauth", :as => :auth_at_provider
    
    namespace :home do
      root "home#index"
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
