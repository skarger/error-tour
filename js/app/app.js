import Application from '@ember/application';
import Resolver from 'ember-resolver';
import loadInitializers from 'ember-load-initializers';
import config from './config/environment';
import Ember from 'ember';

export default class App extends Application {
  modulePrefix = config.modulePrefix;
  podModulePrefix = config.podModulePrefix;
  Resolver = Resolver;
}

Ember.onerror = function(error) {
  console.log(`Ember.onerror: ${error}`);
  window.location.href = '/top-level-error';
}

loadInitializers(App, config.modulePrefix);
