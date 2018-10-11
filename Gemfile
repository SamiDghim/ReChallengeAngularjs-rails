source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end
gem 'devise'
gem 'devise_token_auth'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.6'
#bootstrap
gem 'bootstrap', '~> 4.1.1'
gem 'bootstrap-sass', '~> 3.4.0'
gem 'sassc-rails', '>= 2.0.0'
gem 'jquery-rails'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem 'sprockets'
gem 'angular-rails-templates'
gem "bower-rails", "~> 0.11.0"
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
gem 'coffee-rails'
gem "active_model_serializers"
gem 'angular_rails_csrf'
gem 'will_paginate', '~> 3.1.0'
gem "font-awesome-rails"
gem 'momentjs-rails'
#Angular
gem 'angularjs-rails', '~> 1.5', '>= 1.5.6'
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  gem 'better_errors', '~> 2.1', '>= 2.1.1'
  gem 'rspec-rails', '~> 3.8'
  gem 'pry', '~> 0.11.3'
  gem 'faker', '~> 1.9', '>= 1.9.1'
  gem 'factory_bot_rails', '~> 4.11', '>= 4.11.1'
end
source "https://rails-assets.org" do
  gem "rails-assets-angular-devise"
end
group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem "spring"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
