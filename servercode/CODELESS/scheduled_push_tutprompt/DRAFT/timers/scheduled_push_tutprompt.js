
/**
* Scheduled_Push_TutPrompt timer.
* It is executed according to the schedule
*/
Backendless.ServerCode.addTimer({

  name: 'Scheduled_Push_TutPrompt',

  startDate: 1612707003637,

  frequency: {
    schedule: 'daily',

    repeat: {'every':1}
  },

  /**
  * @param {Object} req
  * @param {String} req.context Application Version Id
  */
  async execute(req){

/*BLOCKLY*/ return Backendless.Messaging.pushWithTemplate('TutPrompt')/*BLOCKLY*/
  }
});