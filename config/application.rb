require File.expand_path('../boot', __FILE__)

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"

Bundler.require(*Rails.groups)

# config.x.fog_dir = 'recipe-scribe'

module RecipeScribe
  class Application < Rails::Application
    config.x.settings = Rails.application.config_for :settings
    config.x.fog_dir = 'recipe-scribe'

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true
  end
end
