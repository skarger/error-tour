import { module, test } from 'qunit';
import { setupTest } from 'ember-qunit';

module('Unit | Controller | top-level-error', function(hooks) {
  setupTest(hooks);

  // Replace this with your real tests.
  test('it exists', function(assert) {
    let controller = this.owner.lookup('controller:top-level-error');
    assert.ok(controller);
  });
});
