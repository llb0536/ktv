require 'rubygems'
require 'spork'

Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However, 
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.
  

  # This file is copied to spec/ when you run 'rails generate rspec:install'
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)

  require "rails/mongoid"
  Spork.trap_class_method(Rails::Mongoid, :load_models)

  require 'rspec/rails'
  require 'rspec/autorun'
  require 'capybara/rspec'
  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    # == Mock Framework
    #
    # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
    #
    # config.mock_with :mocha
    # config.mock_with :flexmock
    # config.mock_with :rr
    config.mock_with :rspec

    # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
    # config.fixture_path = "#{::Rails.root}/spec/fixtures"

    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, remove the following line or assign false
    # instead of true.
    # config.use_transactional_fixtures = true

    # If true, the base class of anonymous controllers will be inferred
    # automatically. This will be the default behavior in future versions of
    # rspec-rails.
    config.infer_base_class_for_anonymous_controllers = false
    # config.mock_with(:mocha)
    config.before(:suite) do
      Mongoid.purge!
      $redis.flushall
      $redis_search.flushall
      $redis_resque.flushall
      $redis_users.flushall
      $redis_topics.flushall
      $redis_asks.flushall
      
      $_users = FactoryGirl.create_list(:user,50)
      $_topics = FactoryGirl.create_list(:topic,25)
      $_asks = FactoryGirl.create_list(:ask,10,:user_id=>$_users[0].id,:current_user_id=>$_users[0].id)
      $_asks += FactoryGirl.create_list(:ask,10,:user_id=>$_users[1].id,:current_user_id=>$_users[1].id)
      $_asks += FactoryGirl.create_list(:ask,10,:user_id=>$_users[2].id,:current_user_id=>$_users[2].id)
    end
    # config.before(:each) { Mongoid::IdentityMap.clear }
  end

end

Spork.each_run do
  # This code will be run each time you run your specs.
  p Time.now
  FactoryGirl.reload
  Dir["#{Rails.root}/app/**/*.rb"].each do |model|
    load model
  end
  Quora::Application.reload_routes!
  p '---------------------------------------------------'
end

# --- Instructions ---
# - Sort through your spec_helper file. Place as much environment loading 
#   code that you don't normally modify during development in the 
#   Spork.prefork block.
# - Place the rest under Spork.each_run block
# - Any code that is left outside of the blocks will be ran during preforking
#   and during each_run!
# - These instructions should self-destruct in 10 seconds.  If they don't,
#   feel free to delete them.
#


