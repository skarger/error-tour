import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { action } from '@ember/object';

export default class ParserError extends Component {
  @tracked json = '';

  @action
  handleInput() {}

  @action
  parseJson() {}
}
