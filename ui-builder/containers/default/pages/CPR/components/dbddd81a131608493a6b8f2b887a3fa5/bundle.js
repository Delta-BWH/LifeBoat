define([], () => ({
  /* content */
  /* handler:onClick */
  async onClick(___arguments) {
      ;await ( async function (url, isExternal, params){ const targetUrl = `${url}?${BackendlessUI.QueryString.stringify(params)}`; isExternal ? window.open(targetUrl, '_blank') : window.location = targetUrl; })('https://www.medicalnewstoday.com/articles/324712#cpr-step-by-step', true, null);

  },  
  /* handler:onClick */
  /* content */
}))
