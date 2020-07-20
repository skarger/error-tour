import Route from '@ember/routing/route';

export default class ApplicationLevelRoute extends Route {
  model() {
    fetch('/no-such-url').then(response => response.json());
  }
}
