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
    config.action_mailer.postmark_settings = { :api_token => "b478ccd7-dcde-4e1b-8ffc-9dcc025d4686" }

  end
end

# Sentry
Raven.configure do |config|
  config.dsn = 'https://80439ce277124fe7a3b44a4c25f1172e:33374df5388146b29d08209b2ce42341@sentry.io/1263763'
end
