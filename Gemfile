source 'https://rubygems.org'

ruby '2.0.0'
gem 'rails', '3.2.13'
gem 'rails-boilerplate'
gem 'bootstrap-sass', '~> 2.3.1.2'
gem 'pg'
gem 'paperclip', '~> 3.0'
# gem 'rmagick'
gem 'ruby-echonest'
gem 'sidekiq'
#gem 'mini_magick'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

group :linux, :test do
  gem 'libnotify'
end


group :development do
  gem 'annotate', '2.5.0'
  gem 'awesome_print'
  gem 'guard-livereload'
end

group :development, :production do
  gem 'retina_tag'
  gem 'aws-sdk', '~> 1.5.7'
  gem 'fb-channel-file'
  gem 'tilt'
  gem 'rails-backbone'
  gem 'react-rails'
  gem 'underscore-rails'
  gem 'stripe', :git => 'https://github.com/stripe/stripe-ruby'
end

group :development, :test do
  gem 'rspec-rails', '2.12.0'
  gem 'guard-rspec', '1.2.1'
  gem 'guard-spork', '1.2.0'
  gem 'childprocess', '0.3.6'
  gem 'spork', '0.9.2'
end

group :test do
  gem 'capybara', '2.1.0'
  gem 'capybara-webkit'
  # gem 'selenium-webdriver'
  # gem 'poltergeist'
  # gem 'factory_girl_rails', '1.0'
  gem 'factory_girl_rails', '4.1.0'
  gem 'faker'
  gem 'rb-fsevent', '0.9.3'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'

  # gem 'jquery.fileupload-rails'
end

gem 'jquery-rails'

group :production do

end

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
