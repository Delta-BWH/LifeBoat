'use strict';

class SampleModel extends Backendless.ServerCode.PersistenceItem {
  constructor(name) {
    super();

    /**
     * @type {String}
     */
    this.name = name || '';
  }
}

module.exports = Backendless.ServerCode.addType(SampleModel);