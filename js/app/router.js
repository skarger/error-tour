import EmberRouter from '@ember/routing/router';
import config from './config/environment';

export default class Router extends EmberRouter {
  location = config.locationType;
  rootURL = config.rootURL;
}

Router.map(function() {
  this.route('result-type');
  this.route('sound-principles');
  this.route('prevention');
  this.route('route-level');
  this.route('other-route');
});
