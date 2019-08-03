# name: lucky-cat-inbox
# version:0.0.1
# authors: luckycat


enabled_site_setting :lucky_cat_onebox_enable

require 'active_support/inflector'
require "ostruct"

PLUGIN_PREFIX = 'lucky_cat_onebox'.freeze
SITE_SETTING_NAME = 'lucky_cat_onebox_enable'.freeze

Dir[File.expand_path('../lib/onebox_override/*.rb', __FILE__)].each { |f| require f }

register_asset "stylesheets/buttons.scss"

after_initialize do
  next unless SiteSetting.lucky_cat_onebox_enable

  Dir[File.expand_path('../lib/onebox/*.rb', __FILE__)].each { |f| require f }
end
