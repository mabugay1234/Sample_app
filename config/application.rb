require_relative 'boot'
require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
Bundler.require(*Rails.groups)
module SampleApp
  class Application < Rails::Application
    config.load_defaults 5.2
    config.generators.system_tests = nil
    config.action_view.embed_authenticity_token_in_remote_forms = true
    config.before_configuration do
      env_file = File.join(Rails.root, "config", "local_env.yml")
      YAML.load(File.open(env_file)).each do |key, value|
        ENV[key.to_s] = value
      end if File.exists?(env_file)
    end
  end
end
