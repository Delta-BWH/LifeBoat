define([], () => ({
  /* content */
  /* handler:onClick */
  async onClick(___arguments) {
      await Backendless.Data.of('allTutorials').remove( 'C1EC93E7-16D8-4B1A-8535-6D5D15D32ABE' )
  ;await ( async function (url, isExternal, params){ const targetUrl = `${url}?${BackendlessUI.QueryString.stringify(params)}`; isExternal ? window.open(targetUrl, '_blank') : window.location = targetUrl; })('https://www.wikihow.com/Change-a-Light-Bulb', true, null);

  },  
  /* handler:onClick */
  /* content */
}))
