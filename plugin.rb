# name: Discourse 中文本地化服务集合
# about: 为 Discourse 增加了各种本地化的功能。
# version: 2.0.0
# authors: Erick Guan
# url: https://github.com/fantasticfears/discourse-chinese-localization-pack

enabled_site_setting :zh_l10n_enabled

require 'active_support/inflector'
require "ostruct"

PLUGIN_PREFIX = 'lucky_cat_onebox'.freeze
SITE_SETTING_NAME = 'lucky_cat_onebox_enable'.freeze

Dir[File.expand_path('../lib/onebox_override/*.rb', __FILE__)].each { |f| require f }

register_asset "stylesheets/buttons.scss"

after_initialize do
  next unless SiteSetting.zh_l10n_enabled

  Dir[File.expand_path('../lib/onebox/*.rb', __FILE__)].each { |f| require f }
end