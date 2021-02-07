define([], () => ({
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
