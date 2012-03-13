# Load the rails application
require File.expand_path('../application', __FILE__)
require "#{Rails.root}/lib/sp_clock.rb"
APP_CONFIG = YAML::load(ERB.new(IO.read(Rails.root.join("config","application.yml"))).result)[Rails.env]
# Initialize the rails application
SPC2::Application.initialize!