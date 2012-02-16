source 'https://rubygems.org'

gem 'rails', '3.2.1'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sorcery', "0.7.6"
gem 'execjs', "1.3.0"
gem 'therubyracer',"0.9.9", :platforms => :ruby
group :production do
  gem "pg"
end
group :development, :test do
  gem 'sqlite3'
  gem "rspec-rails", "~> 2.6"
end

group :test do
  gem "factory_girl_rails"
  gem "capybara"
  gem 'rb-fsevent', :require => false if RUBY_PLATFORM =~ /darwin/i
  gem "guard"
  gem "guard-rspec"
end
gem 'json', "1.6.5"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer'

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails', "2.0.0"

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug'
