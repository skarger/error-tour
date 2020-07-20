import Controller from '@ember/controller';

export default class TopLevelErrorController extends Controller {
  queryParams = ['type', 'message'];
}
