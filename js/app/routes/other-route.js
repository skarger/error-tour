import Route from '@ember/routing/route';

export default class ApplicationLevelRoute extends Route {
  model() {
    throw new Error("shows application level error template");
  }
}
