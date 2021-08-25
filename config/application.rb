# frozen_string_literal: true

require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_mailbox/engine'
require 'action_text/engine'
require 'action_view/railtie'
require 'action_cable/engine'
require 'sprockets/railtie'
# require "rails/test_unit/railtie"
require_relative '../lib/authentication/token_strategy'
require_relative '../lib/authentication/set_response_token'

Bundler.require(*Rails.groups)

module Smartflix
  class Application < Rails::Application

    config.load_defaults 6.1
    config.generators.system_tests = nil
    config.autoload_paths << Rails.root.join('lib')
    config.eager_load_paths << Rails.root.join('lib')
    # config.api_only = true
    # config.autoload_paths += %W( #{config.root}/lib )
    config.middleware.use Warden::Manager do |manager|
      manager.default_strategies :token
      manager.failure_app = proc { |_env|
        ['401', { 'Content-Type' => 'application/json' }, { error: 'Unauthorized', code: 401 }]
      }
    end

    config.middleware.use Authentication::SetResponseToken

  end
end
