import Route from '@ember/routing/route';
import { action } from '@ember/object';
import Ember from 'ember';

export default class ApplicationRoute extends Route {
  @action
  error(e) {
    Ember.onerror(e);
  }
}
