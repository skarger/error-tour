import Route from '@ember/routing/route';

export default class ApplicationLevelRoute extends Route {
  model() {
    throw new Error("an error bubbled up to application level error template");
  }
}
