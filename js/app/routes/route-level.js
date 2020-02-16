import Route from '@ember/routing/route';

export default class RouteLevelRoute extends Route {
  model() {
    throw new Error("bad");
  }
}
