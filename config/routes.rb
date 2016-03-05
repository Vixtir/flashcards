Rails.application.routes.draw do
  scope "(:locale)", locale: /en|ru/ do
    post "oauth/callback" => "oauths#callback"
    get "oauth/callback" => "oauths#callback" # for use with Github, Facebook
    get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
    patch "/decks/:id" => "decks#activate", :as => :activate
    get '/:locale' => 'home#index'
    root "home#index"
    post "check" => "cards#check"
    post "grade" => "cards#grade"
    resources :cards
    resources :users
    resources :user_sessions
    resources :decks

    get "login" => "user_sessions#new", :as => :login
    post "logout" => "user_sessions#destroy", :as => :logout
  end
end
