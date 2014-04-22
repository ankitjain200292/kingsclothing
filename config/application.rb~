require File.expand_path('../boot', __FILE__)

require 'rails/all'
#config.assets.enabled = true
#config.assets.paths << "#{Rails.root}/app/assets/fonts"
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Kingsclothing
  class Application < Rails::Application
    config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif)
    config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
    config.assets.paths << "#{Rails.root}/app/assets/video"
  end
end
