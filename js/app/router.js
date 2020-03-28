import EmberRouter from '@ember/routing/router';
import config from './config/environment';

export default class Router extends EmberRouter {
  location = config.locationType;
  rootURL = config.rootURL;
}

Router.map(function() {
  this.route('sound-principles');
  this.route('prevention');
  this.route('route-level');
  this.route('other-route');
  this.route('error-substates');
  this.route('exceptions');
  this.route('return-value');
  this.route('errno');
  this.route('errors-as-data');
  this.route('elm-parse-int');
  this.route('rust-parse-int');
});
