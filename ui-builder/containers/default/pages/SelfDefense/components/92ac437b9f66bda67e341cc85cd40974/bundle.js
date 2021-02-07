define([], () => ({
  /* content */
  /* handler:onClick */
  async onClick(___arguments) {
      ;await ( async function (url, isExternal, params){ const targetUrl = `${url}?${BackendlessUI.QueryString.stringify(params)}`; isExternal ? window.open(targetUrl, '_blank') : window.location = targetUrl; })('https://www.healthline.com/health/womens-health/self-defense-tips-escape', true, null);

  },  
  /* handler:onClick */
  /* content */
}))
