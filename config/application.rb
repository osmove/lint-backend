require_relative 'boot'
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Omnilint
  class Application < Rails::Application
    # Initialize configuration defaults for Rails 7.2
    config.load_defaults 7.2

    # Autoloading (Zeitwerk)
    config.autoloader = :zeitwerk

    # Postmark
    config.action_mailer.delivery_method = :postmark
    config.action_mailer.postmark_settings = { api_token: ENV.fetch("POSTMARK_API_TOKEN", "") }
  end
end

# Sentry (replaces deprecated sentry-raven)
Sentry.init do |config|
  config.dsn = ENV.fetch("SENTRY_DSN", "")
  config.breadcrumbs_logger = [:active_support_logger, :http_logger]
  config.traces_sample_rate = ENV.fetch("SENTRY_TRACES_SAMPLE_RATE", "0.1").to_f
end
