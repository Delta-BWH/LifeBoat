require.config({
    waitSeconds: 60,
    paths: {
        'sdk': uiBuilderSDKPath + '/sdk',
    }
});

define(['sdk'], BackendlessUI => BackendlessUI.startApp());

define('./pages/404/components/page/bundle.js', [], () => ({
  /* content */

  /* handler:onEnter */
  async onEnter(___arguments) {
      ___arguments.context.pageData['error'] = null;
  ___arguments.context.pageData['user'] = (
      await (async function(userIdentity){
        var userColumns = await Backendless.UserService.describeUserClass()
        var identityColumn = userColumns.find(column => column.identity)
        var whereClause = `${identityColumn.name} = '${userIdentity}'`
        var query = Backendless.DataQueryBuilder.create().setWhereClause(whereClause)
        var users = await Backendless.Data.of(Backendless.User).find(query)

        return users[0]
     })((___arguments.context.pageData['userIdentity']))
  );

  },  
/* handler:onEnter *//* content */
}));

define('./pages/404/components/3665111f5a5b9f8f4b064bbdf6ce7a5c/bundle.js', [], () => ({
  /* content */
  /* handler:onClick */
  async onClick(___arguments) {
      ;await ( async function (pageName, pageData){ BackendlessUI.goToPage(pageName, pageData) })('', null);

  },  
  /* handler:onClick */
  /* content */
}))

define('./pages/change-password/components/page/bundle.js', [], () => ({
  /* content */

  /* handler:onEnter */
  onEnter(___arguments) {
      ___arguments.context.pageData['error'] = null;
  ___arguments.context.pageData['result'] = null;

  },  
/* handler:onEnter *//* content */
}));

define('./pages/change-password/components/58ecb77e91b7d9dd5c99075111c91c64/bundle.js', [], () => ({
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

define('./pages/change-password/components/9c0e75137e04bad6e50940e30ee54426/bundle.js', [], () => ({
  /* content */

  /* handler:onChange */
  onChange(___arguments) {
      ___arguments.context.pageData['error'] = null;
  ___arguments.context.pageData['result'] = null;

  },  
/* handler:onChange *//* content */
}));

define('./pages/change-password/components/1e3bdf67c1f295ed344408cd7f1dba1d/bundle.js', [], () => ({
  /* content */

  /* handler:onChange */
  onChange(___arguments) {
      ___arguments.context.pageData['error'] = null;
  ___arguments.context.pageData['result'] = null;

  },  
/* handler:onChange *//* content */
}));

define('./pages/logged-in/components/page/bundle.js', [], () => ({
  /* content */
  /* handler:onEnter */
  async onEnter(___arguments) {
    var currentUser;


  if (!(___arguments.context.appData['currenUser'])) {
    ___arguments.context.appData['currenUser'] = (await Backendless.UserService.getCurrentUser());
  }
  currentUser = (___arguments.context.appData['currenUser']);
  if (!currentUser) {
    ;await ( async function (pageName, pageData){ BackendlessUI.goToPage(pageName, pageData) })('login', null);
  }

  },  
  /* handler:onEnter */
  /* content */
}))

define('./pages/login/components/85dae34486144e2efa2d934bfdddb172/bundle.js', [], () => ({
  /* content */

  /* handler:onSubmit */
  async onSubmit(___arguments) {
    var error, stayLoggedIn, password, username, user, redirectData, redirectToPageName, redirectToUrl, logging, buttonLogin;

/**
 * Describe this function...
 */
async function login() {
  try {
    user = (await Backendless.UserService.login( username, password, stayLoggedIn  ));

  } catch (error) {
    await setError(error);

  }
}

/**
 * Describe this function...
 */
async function setError(error) {
  ((function (componentUid){ return ___arguments.context.getComponentDataStoreByUid(componentUid) })('85dae34486144e2efa2d934bfdddb172'))['error'] = error;
}

/**
 * Describe this function...
 */
async function updateButtonLogin(logging) {
  buttonLogin = ((function (componentUid){ return ___arguments.context.getComponentByUid(componentUid) })('db5546014b7940ad8771a98d85f83036'));
  buttonLogin['label'] = (logging ? 'Please wait...' : 'Login');
  buttonLogin['disabled'] = logging;
}


  redirectToUrl = (___arguments.context.pageData['redirectToUrl']);
  redirectToPageName = (___arguments.context.pageData['redirectToPageName']);
  redirectData = (___arguments.context.pageData['redirectData']);
  await setError(null);
  username = (___arguments.context.dataModel['username']);
  password = (___arguments.context.dataModel['password']);
  stayLoggedIn = (___arguments.context.dataModel['stayLoggedIn']);
  if (username && password) {
    await updateButtonLogin(true);
    try {
      await login();

    } catch (error) {
      if ((error['code']) == 3033) {
        await login();
      } else {
        await setError(error);
      }

    } finally {
      await updateButtonLogin(false);

    }
  } else {
    await setError((new Error('Username and Password must be filled')));
  }
  if (user) {
    ___arguments.context.appData['currentUser'] = user;
    if (redirectToUrl) {
      ;await ( async function (url, isExternal, params){ const targetUrl = `${url}?${BackendlessUI.QueryString.stringify(params)}`; isExternal ? window.open(targetUrl, '_blank') : window.location = targetUrl; })(redirectToUrl, false, null);
    } else if (redirectToPageName) {
      ;await ( async function (pageName, pageData){ BackendlessUI.goToPage(pageName, pageData) })(redirectToPageName, (redirectData ? (JSON.parse(redirectData)) : null));
    } else {
      ;await ( async function (pageName, pageData){ BackendlessUI.goToPage(pageName, pageData) })('logged-in', null);
    }
  }

  },  
  /* handler:onSubmit *//* content */
}));

define('./pages/login/components/page/bundle.js', [], () => ({
  /* content */
  /* handler:onEnter */
  async onEnter(___arguments) {
    var redirectData, redirectToPageName, redirectToUrl, currentUser;


  currentUser = (___arguments.context.appData['currentUser']) ? (___arguments.context.appData['currentUser']) : (await Backendless.UserService.getCurrentUser());
  redirectToUrl = (___arguments.context.pageData['redirectToUrl']);
  redirectToPageName = (___arguments.context.pageData['redirectToPageName']);
  redirectData = (___arguments.context.pageData['redirectData']);
  if (currentUser) {
    if (redirectToUrl) {
      ;await ( async function (url, isExternal, params){ const targetUrl = `${url}?${BackendlessUI.QueryString.stringify(params)}`; isExternal ? window.open(targetUrl, '_blank') : window.location = targetUrl; })(redirectToUrl, false, null);
    } else if (redirectToPageName) {
      ;await ( async function (pageName, pageData){ BackendlessUI.goToPage(pageName, pageData) })(redirectToPageName, (redirectData ? (JSON.parse(redirectData)) : null));
    } else {
      ;await ( async function (pageName, pageData){ BackendlessUI.goToPage(pageName, pageData) })('logged-in', null);
    }
  }

  },  
  /* handler:onEnter */
  /* content */
}))
