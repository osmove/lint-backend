require_relative 'boot'
require 'kaminari'
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Omnilint
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Postmark
    config.action_mailer.delivery_method = :postmark
    config.action_mailer.postmark_settings = { :api_token => ENV.fetch("POSTMARK_API_TOKEN", "") }

    # Fix problem with login error HTTP Origin header (https://lint.dev) didn't match request.base_url (http://lint.dev)
    # https://github.com/rails/rails/issues/22965
    config.action_controller.forgery_protection_origin_check = false
  end
end

# Sentry
Raven.configure do |config|
  config.dsn = ENV.fetch("SENTRY_DSN", "")
end
