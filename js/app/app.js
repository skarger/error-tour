import Application from '@ember/application';
import Resolver from 'ember-resolver';
import loadInitializers from 'ember-load-initializers';
import config from './config/environment';

export default class App extends Application {
  modulePrefix = config.modulePrefix;
  podModulePrefix = config.podModulePrefix;
  Resolver = Resolver;
}

window.onerror = function(message) {
  window.location.href = `/top-level-error?type=Exception&message=${message}`;
}

window.addEventListener('unhandledrejection', function(event) {
  window.location.href = `/top-level-error?type=Rejected+Promise&message=${event.reason}`;
});

loadInitializers(App, config.modulePrefix);
