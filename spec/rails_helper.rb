
ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../../config/environment", __FILE__)

abort("The Rails environment is running in production mode!") if Rails.env.production?
require "spec_helper"
require "rspec/rails"
require "capybara/rails"
require "capybara/rspec"
require "factory_girl_rails"

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.include Sorcery::TestHelpers::Rails
  config.include FactoryGirl::Syntax::Methods
  config.include Capybara::DSL
  config.include WaitForAjax, type: :feature
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  Capybara.javascript_driver = :webkit

  config.use_transactional_fixtures = false

  config.before(:suite) do
    if config.use_transactional_fixtures?
      raise(<<-MSG)
            Delete line `config.use_transactional_fixtures = true` from rails_helper.rb
            (or set it to false) to prevent uncommitted transactions being used in
            JavaScript-dependent specs.

            During testing, the app-under-test that the browser driver connects to
            uses a different database connection to the database connection used by
            the spec. The app's database connection would not be able to access
            uncommitted transaction data setup over the spec's database connection.
          MSG
    end
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, type: :feature) do
    # :rack_test driver's Rack app under test shares database connection
    # with the specs, so continue to use transaction strategy for speed.
    driver_shares_db_connection_with_specs = Capybara.current_driver == :rack_test

    unless driver_shares_db_connection_with_specs
      # Driver is probably for an external browser with an app
      # under test that does *not* share a database connection with the
      # specs, so use truncation strategy.
      DatabaseCleaner.strategy = :truncation
    end
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.append_after(:each) do
    DatabaseCleaner.clean
  end

  def login(email, password)
    visit login_path
    fill_in :email, with: email
    fill_in :password, with: password
    click_button "Login"
  end
end
