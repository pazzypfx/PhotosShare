source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.1.3.1'
# Use postgresql as the database for Active Record
gem 'pg'
# Use Puma as the app server
gem 'puma', '~> 4.3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.9.1'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'
# Warden for authentication
gem 'warden'

# Uploading and processing photos
gem 'carrierwave', '~> 1.0'
gem 'mini_magick'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# Use will_paginate for page pagination
gem 'will_paginate', '~> 3.1.0'

gem 'slim'

# Managing authorizations
gem 'cancancan'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri

  gem 'pry-byebug'
  gem 'pry-rails'

  gem 'database_cleaner'
  gem 'factory_bot_rails'

  gem 'fuubar'
  gem 'rspec_junit_formatter'
  gem 'rspec-rails', '~> 4.0.1'
  # gem 'shoulda-matchers'

  gem 'awesome_print', require: false
  gem 'faker'

  gem 'debase'
  gem 'ruby-debug-ide'

  gem 'rubocop', '~> 0.89.1', require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rails", require: false
end

group :development do
  # Better Errors replaces the standard Rails error page
  gem 'better_errors'
  # Listens to file modifications and notifies you about the changes
  gem 'listen', '~> 3.0.5'
  # Single line logs
  gem 'lograge'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
end

group :test do
  gem 'codecov', require: false
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
end
