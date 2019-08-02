import Sharing from 'discourse/lib/sharing';
import { withPluginApi } from 'discourse/lib/plugin-api';

function initializeWithApi(api) {
  const siteSettings = api.container.lookup('site-settings:main');
  if (!siteSettings.lucky_cat_onebox_enable) return;

  addSharingSources();
}

function addSharingSources() {
  
}

export default {
  name: 'lucky_cat_onebox',

  initialize() {
    withPluginApi('0.1', initializeWithApi);
  }
}
