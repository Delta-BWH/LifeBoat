define([], () => ({
  /* content */

  /* handler:onSubmit */
  async onSubmit(___arguments) {
    var error;


  ___arguments.context.pageData['result'] = '';
  ___arguments.context.pageData['error'] = '';
  if ((___arguments.context.dataModel['password']) == (___arguments.context.dataModel['confirm_password'])) {
    try {
      ___arguments.context.pageData['result'] = (await Backendless.Request['post']((function(url){ if( !url ) { throw new Error('Url must be specified.')} if( !url.startsWith('http://') && !url.startsWith('https://')) { return 'https://' + url } return url})(([(Backendless.appPath),'/change_password/',(___arguments.context.pageData['token'])].join('')))).send(({ 'password': (___arguments.context.dataModel['password']) })));

    } catch (error) {
      ___arguments.context.pageData['error'] = ((typeof (error['message']) === 'string') ? (error['message']) : error);

    }
  } else {
    ___arguments.context.pageData['error'] = 'Passwords do not match';
  }

  },  
  /* handler:onSubmit *//* content */
}));
