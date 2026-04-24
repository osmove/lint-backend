require_relative 'boot'
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Lint
  class Application < Rails::Application
    # Initialize configuration defaults for Rails 7.2
    config.load_defaults 7.2

    # Autoloading (Zeitwerk)
    config.autoloader = :zeitwerk

    # Postmark
    config.action_mailer.delivery_method = :postmark
    config.action_mailer.postmark_settings = { api_token: ENV.fetch('POSTMARK_API_TOKEN', '') }

    # Payment providers
    config.x.stripe = {
      publishable_key: ENV.fetch('STRIPE_PUBLISHABLE_KEY', ''),
      secret_key: ENV.fetch('STRIPE_SECRET_KEY', '')
    }
  end
end
