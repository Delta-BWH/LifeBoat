'use strict';

const SampleModel = require('../models/SampleModel');

class SampleService {
  /**
   * @param {String} name
   * @returns {String}
   */
  sampleServiceMethod(name) {
    const sampleModelInstance = new SampleModel(name);

    return sampleModelInstance.save()
      .then(savedModel => `Sample object has been saved. objectId - ${savedModel.objectId}`);
  }
}

SampleService.version = '1.0.0';

Backendless.ServerCode.addService(SampleService);