FactoryGirl.define do
  factory :user do
    email "user@email.com"
    password "password"
    password_confirmation "password"
    salt { "asdasdastr4325234324sdfds" }
    crypted_password { Sorcery::CryptoProviders::BCrypt.encrypt("secret", 
                     "asdasdastr4325234324sdfds") }
  end
end
