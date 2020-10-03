import Ember from 'ember';

export function initialize(/* appInstance */) {
  // appInstance.inject('route', 'foo', 'service:foo');
  console.log('ii on-error');
  Ember.onerror = function(e) {
    window.location.href = `/top-level-error?type=Ember.onerror&message=${e}`;
  }
}

export default {
  initialize
};
