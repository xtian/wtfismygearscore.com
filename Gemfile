source 'https://rubygems.org'
ruby '2.3.0'

gem 'rails', '>= 5.0.0.beta3', '< 5.1'

gem 'jquery-rails' # Use jquery as the JavaScript library
gem 'pg', '~> 0.18' # Use postgresql as the database for Active Record
gem 'puma' # Use Puma as the app server
gem 'rack-timeout' # Abort requests that are taking too long
gem 'sass-rails', '~> 5.0' # Use SCSS for stylesheets
gem 'turbolinks', '~> 5.x' # Makes navigating your web application faster
gem 'uglifier', '>= 1.3.0' # Use Uglifier as compressor for JavaScript assets

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  gem 'byebug' # Speeds up development by keeping your application running in the background
  gem 'coderay' # Syntax highlighting for RSpec failures
  gem 'rspec-rails' # Test framework
  gem 'rubocop', require: false # Ensures consistent Ruby style
  gem 'rubocop-rspec', require: false # Ensures consistent RSpec style
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 3.0'
  gem 'listen', '~> 3.0.5'

  # Spring speeds up development by keeping your application running in the background
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'fuubar' # RSpec progress bar formatter
  gem 'shoulda-matchers' # Rails RSpec helpers
  gem 'webmock' # Mocks external requests
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
