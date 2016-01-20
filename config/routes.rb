Rails.application.routes.draw do
  root "home#index"
  post "check" => "cards#check"
  resources :cards
end
