define([], () => ({
  /* content */
  /* handler:onClick */
  async onClick(___arguments) {
      if ((await Backendless.Counters.get('len')) != 0) {
    await Backendless.Cache.remove('2')
    await Backendless.Counters.decrementAndGet('len');
  }
  ;await ( async function (pageName, pageData){ BackendlessUI.goToPage(pageName, pageData) })('WelcomePage', null);

  },  
  /* handler:onClick */
  /* content */
}))
