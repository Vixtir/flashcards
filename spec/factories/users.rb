FactoryGirl.define do
  factory :user do
    email "user@email.com"
    password "password"
    password_confirmation "password"
  end
end
