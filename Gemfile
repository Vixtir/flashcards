source 'https://rubygems.org'
ruby "2.2.3"
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.4'
# Use postgresql as the database for Active Record
gem 'pg'
gem 'nokogiri'
gem 'sorcery'
gem 'figaro'
gem 'carrierwave', github: 'carrierwaveuploader/carrierwave'
gem 'rmagick'
gem 'fog', require: 'fog/aws'
gem 'travis'
gem 'rails_12factor', group: :production
gem 'puma'
gem 'levenshtein', '~> 0.2.2'
gem 'whenever', require: false
gem 'mailgun_rails'
gem 'http_accept_language'
gem 'rollbar'
gem 'raygun4ruby'
#gem 'fog-aws'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
gem 'simple_form'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
#gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development do
    gem 'capistrano',         require: false
    gem 'capistrano-rvm',     require: false
    gem 'capistrano-rails',   require: false
    gem 'capistrano-bundler', require: false
    gem 'capistrano3-puma',   require: false
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'rspec-rails', '~> 3.0'
end

group :test do
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'database_cleaner'
end

gem 'factory_girl_rails', "~> 4.0"
group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end
