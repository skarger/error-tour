import Component from '@glimmer/component';
import { action } from '@ember/object';

export default class Example extends Component {
  @action
  boom() {
    throw new Error('Boom');
  }

  get property() {
    throw new Error('Getter error');
  }
}
