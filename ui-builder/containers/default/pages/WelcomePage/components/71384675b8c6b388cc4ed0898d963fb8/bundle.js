define([], () => ({
  /* content */
  /* handler:onClick */
  async onClick(___arguments) {
      ;await ( async function (pageName, pageData){ BackendlessUI.goToPage(pageName, pageData) })((await Backendless.Cache.get((JSON.stringify((await Backendless.Counters.get('len')))))), ___arguments.context.appData);

  },  
  /* handler:onClick */
  /* content */
}))
