
/**
* CacheExtend timer.
* It is executed according to the schedule
*/
Backendless.ServerCode.addTimer({

  name: 'CacheExtend',

  startDate: 1612711334992,

  frequency: {
    schedule: 'custom',

    repeat: {'every':7100}
  },

  /**
  * @param {Object} req
  * @param {String} req.context Application Version Id
  */
  execute(req){
   Backendless.Cache.expireIn( "1", 7200);
   Backendless.Cache.expireIn( "2", 7200);
   Backendless.Cache.expireIn( "3", 7200);
   Backendless.Cache.expireIn( "4", 7200);
   Backendless.Cache.expireIn( "5", 7200);
   Backendless.Cache.expireIn( "6", 7200);
   Backendless.Cache.expireIn( "7", 7200);
  }
});