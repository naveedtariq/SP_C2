# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rspec'
require 'database_cleaner'
require 'csv'    

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr


  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false
  config.before :each do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start 
    DatabaseCleaner.clean
    load "#{Rails.root}/db/seeds.rb"

    csv_text = File.read("#{Rails.root}/spec/data/user.csv")
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      row = row.to_hash.with_indifferent_access
      u = User.new(row.to_hash.symbolize_keys)
      u.photo = File.open("#{Rails.root}/spec/data/dont_delete.png")
      u.save!
    end
    csv_text = File.read("#{Rails.root}/spec/data/ride.csv")
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      row = row.to_hash.with_indifferent_access
      Ride.create!(row.to_hash.symbolize_keys)
    end
    csv_text = File.read("#{Rails.root}/spec/data/location.csv")
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      row = row.to_hash.with_indifferent_access
      Location.create!(row.to_hash.symbolize_keys)
    end
  end

  config.after do
  end
  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false
end
