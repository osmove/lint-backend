source 'https://rubygems.org'

ruby '3.4.9'

# Core
gem 'dotenv-rails', groups: %i[development test]
gem 'pg', '~> 1.5'
gem 'puma', '~> 8.0'
gem 'rails', '~> 8.1'

# Asset Pipeline
gem 'dartsass-rails', '~> 0.5'
gem 'image_processing', '~> 1.14'
gem 'jbuilder', '~> 2.12'
gem 'sprockets-rails'
gem 'terser'

# Hotwire (replaces Turbolinks + jQuery)
gem 'importmap-rails'
gem 'stimulus-rails'
gem 'turbo-rails'

# UI
gem 'font-awesome-sass', '~> 6.5'

# Tailwind is the app-wide CSS framework. Legacy Rails views still emit
# older utility/component class names while they are being rewritten;
# app/assets/tailwind/legacy-ui.css maps those selectors onto local
# Tailwind-era styles without shipping another CSS framework.
gem 'tailwindcss-rails', '~> 4.3'

# Authentication
gem 'devise', '~> 5.0'
gem 'omniauth-github', '~> 2.0'
gem 'omniauth-rails_csrf_protection'

# Forms & URLs
gem 'friendly_id', '~> 5.5'

# Infrastructure
gem 'browser', '~> 6.0'
gem 'faraday', '~> 2.9'
gem 'git'
gem 'net-ssh', '~> 7.2'
gem 'postmark-rails', '~> 0.22'
gem 'redcarpet', '~> 3.6'
gem 'rqrcode', '~> 3.2'
gem 'stripe', '~> 19.0'

# Monitoring
gem 'sentry-rails', '~> 6.5'
gem 'sentry-ruby', '~> 6.5'

# Analytics & Tracking
gem 'blazer', '~> 3.0'
gem 'chartkick', '~> 5.1'
gem 'groupdate', '~> 6.4'
gem 'hightop', '~> 1.0'
gem 'kaminari', '~> 1.2'

# Notifications
gem 'exponent-server-sdk'

# Utilities
gem 'colorize'

group :development, :test do
  gem 'capybara', '~> 3.40'
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'letter_opener'
  gem 'minitest', '~> 6.0'
  gem 'selenium-webdriver', '~> 4.16'
end

group :development do
  gem 'brakeman', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'web-console', '~> 4.3'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
