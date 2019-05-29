Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  if Rails.root.join('tmp/caching-dev.txt').exist?
    config.action_controller.perform_caching = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.seconds.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Rails.application.routes.default_url_options[:host] = 'localhost'
  Rails.application.routes.default_url_options[:host] = 'localhost:3000'

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  # Letter Opener
  config.action_mailer.delivery_method = :letter_opener
  config.action_mailer.perform_deliveries = true

  # Omniauth github api
  # config.omniauth :github, 'c6970dc8ce50f48bbd7e', '49947ed386d02c5ce282eb3baaf978d92325598b', scope: 'user, repo, read:org, admin:repo_hook, repo_deployment', :redirect_uri => 'http://localhost:3000/users/auth/github'

end




Devise.setup do |config|
  config.omniauth :github, 'aae25e7b1428bbec9be7', '33c19ebca07374476393ee83d6d2cecc18c1fa2d', scope: 'read:user, public_repo, read:org', :redirect_uri => 'http://localhost:3000/users/auth/github/callback'
  # config.omniauth :github, 'aae25e7b1428bbec9be7', '33c19ebca07374476393ee83d6d2cecc18c1fa2d', scope: 'read:user, public_repo, read:org', :redirect_uri => 'http://localhost:3000/users/auth/github'
  # config.omniauth :github, 'aae25e7b1428bbec9be7', '33c19ebca07374476393ee83d6d2cecc18c1fa2d', scope: 'user, repo, read:org, admin:repo_hook, repo_deployment', :redirect_uri => 'http://localhost:3000/users/auth/github'
end


Rails.configuration.stripe = {
  :publishable_key => 'pk_test_eBB6xUuMesZwAGiVN1f09kox',
  :secret_key      => 'STRIPE_TEST_KEY_REDACTED'
}
