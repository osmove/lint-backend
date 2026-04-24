source 'https://rubygems.org'

ruby '3.4.9'

# Pin notes
# -----------
# rails ~> 7.2: Rails 8 is blocked by `impressionist` 2.0.0 which still calls
#   the pre-8 autoloader constant (`Impressionist::Engine::ImpressionistController`).
#   Upgrade once upstream ships Rails 8 support or we replace impressionist.
# web-console ~> 4.2: web-console 4.3 requires Rails 8, pinned accordingly.
# minitest < 6: Rails 7.2 railties test_unit/line_filtering.rb calls
#   `run(suite, type, filter)` but minitest 6 expects 1..2 args. Revisit with
#   the Rails 8 upgrade.

# Core
gem 'rails', '~> 7.2'
gem 'dotenv-rails', groups: [:development, :test]
gem 'pg', '~> 1.5'
gem 'puma', '~> 8.0'

# Asset Pipeline
gem 'sprockets-rails'
gem 'dartsass-rails', '~> 0.5'
gem 'terser'
gem 'jbuilder', '~> 2.12'

# Hotwire (replaces Turbolinks + jQuery)
gem 'turbo-rails'
gem 'stimulus-rails'
gem 'importmap-rails'

# UI
gem 'bootstrap', '~> 5.3'
gem 'font-awesome-sass', '~> 6.5'

# Authentication
gem 'devise', '~> 5.0'
gem 'omniauth-github', '~> 2.0'
gem 'omniauth-rails_csrf_protection'

# Forms & URLs
gem 'bootstrap_form', '~> 5.4'
gem 'friendly_id', '~> 5.5'

# Infrastructure
gem 'faraday', '~> 2.9'
gem 'net-ssh', '~> 7.2'
gem 'postmark-rails', '~> 0.22'
gem 'rqrcode', '~> 3.2'
gem 'stripe', '~> 19.0'
gem 'git'
gem 'browser', '~> 6.0'
gem 'redcarpet', '~> 3.6'

# Monitoring
gem 'sentry-ruby', '~> 6.5'
gem 'sentry-rails', '~> 6.5'

# Analytics & Tracking
gem 'impressionist'
gem 'kaminari', '~> 1.2'
gem 'chartkick', '~> 5.1'
gem 'groupdate', '~> 6.4'
gem 'hightop', '~> 1.0'
gem 'blazer', '~> 3.0'

# Notifications
gem 'exponent-server-sdk'

# Utilities
gem 'colorize'

group :development, :test do
  gem 'debug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 3.40'
  gem 'selenium-webdriver', '~> 4.16'
  gem 'letter_opener'
  gem 'factory_bot_rails'
  gem 'minitest', '< 6'
end

group :development do
  gem 'web-console', '~> 4.2'
  gem 'rubocop-rails', require: false
  gem 'rubocop-performance', require: false
  gem 'brakeman', require: false
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
