require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module GalleryShare
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Set up logging to be the same in all environments but control the level
    # through an environment variable.
    config.log_level = ENV["LOG_LEVEL"] || :debug

    # Log to STDOUT because Docker expects all processes to log here. You could
    # then redirect logs to a third party service on your own such as systemd,
    # or a third party host such as Loggly, etc..
    # logger           = ActiveSupport::Logger.new(STDOUT)
    # logger.formatter = config.log_formatter
    # config.log_tags  = %i[subdomain uuid]
    # config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end
end
