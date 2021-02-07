define([], () => ({
  /* content */
  /* handler:onClick */
  async onClick(___arguments) {
      ;await ( async function (url, isExternal, params){ const targetUrl = `${url}?${BackendlessUI.QueryString.stringify(params)}`; isExternal ? window.open(targetUrl, '_blank') : window.location = targetUrl; })('https://www.thespruce.com/how-to-do-laundry-2146149', true, null);

  },  
  /* handler:onClick */
  /* content */
}))
