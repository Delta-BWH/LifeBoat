define([], () => ({
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
