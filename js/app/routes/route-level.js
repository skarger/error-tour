import Route from '@ember/routing/route';

export default class SomeRoute extends Route {
  model() {
    throw new Error("bad");
  }
}
