# frozen_string_literal: true
source 'https://rubygems.org'
ruby '2.3.1'

gem 'rails', '>= 5.0.0.beta3', '< 5.1'

gem 'autoprefixer-rails' # Generates vendor-prefixed CSS
gem 'babel-transpiler' # Compiles new JS syntax into ES5-compatible code
gem 'faraday' # HTTP client
gem 'fast_blank' # Provides a fast implementation of Active Support's String#blank? method
gem 'normalize-rails' # Base CSS reset
gem 'pg' # Use postgresql as the database for Active Record
gem 'puma' # Use Puma as the app server
gem 'redis' # Redis client gem
gem 'ruby_identicon' # Avatar generator
gem 'sass-rails', '>= 6.0.0.beta1' # Use SCSS for stylesheets
gem 'sidekiq' # Background job queue built on Redis
gem 'sidekiq-unique-jobs' # Prevents duplicate jobs from being enqueued
gem 'scenic' # Create and manage database views in Rails
gem 'sprockets', '>= 4.0.0.beta2' # Asset compilation pipeline for CSS, JS, and images
gem 'turbolinks', '>= 5.0.0.beta2' # Makes navigating your web application faster
gem 'typhoeus' # HTTP client backend for Faraday
gem 'uglifier', '>= 1.3.0' # Use Uglifier as compressor for JavaScript assets

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :production do
  gem 'rack-throttle' # Provides logic for rate-limiting incoming HTTP requests
  gem 'rack-timeout' # Abort requests that are taking too long
end

group :development, :test do
  gem 'byebug' # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'coderay', require: false # Syntax highlighting for RSpec failures
  gem 'eslint-rails' # Ensures consistent JavaScript style
  gem 'mutant-rspec', require: false # Mutation testing tool
  gem 'rspec-rails', '>= 3.5.0.beta3' # Test framework
  gem 'rubocop', require: false # Ensures consistent Ruby style
  gem 'rubocop-rspec', require: false # Ensures consistent RSpec style
  gem 'scss_lint', require: false # Ensures consistent SCSS style
end

group :development do
  gem 'guard', require: false # Tool to perform actions on file modification
  gem 'guard-livereload', require: false # Reloads page when view-related files are changed
  gem 'listen' # Watches file system for changes
  gem 'quiet_assets' # Strips noisy asset requests from the log
  gem 'rack-livereload' # Injects livereload snippet
  gem 'spring' # Keeps application running in the background
  gem 'spring-commands-rspec' # Implements the rspec command for Spring
  gem 'spring-watcher-listen' # Uses Listen to watch for changes instead of polling
  gem 'web-console' # Access an IRB console on exception pages or by using <%= console %> in views
end

group :test do
  gem 'capybara' # Allows simulation of user interaction in feature specs
  gem 'fabrication' # Allows creation of model objects with default data
  gem 'fakeredis', require: 'fakeredis/rspec' # Fake implementation of redis-rb
  gem 'fuubar', '>= 2.1.0.beta2' # RSpec progress bar formatter
  gem 'shoulda-matchers' # Rails RSpec helpers
  gem 'webmock' # Mocks external requests
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
