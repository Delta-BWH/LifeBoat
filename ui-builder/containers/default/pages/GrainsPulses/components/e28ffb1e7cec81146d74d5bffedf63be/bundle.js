define([], () => ({
  /* content */
  /* handler:onClick */
  async onClick(___arguments) {
      ;await ( async function (url, isExternal, params){ const targetUrl = `${url}?${BackendlessUI.QueryString.stringify(params)}`; isExternal ? window.open(targetUrl, '_blank') : window.location = targetUrl; })('https://www.asdagoodliving.co.uk/food/features/an-experts-guide-to-grains-and-pulses', true, null);

  },  
  /* handler:onClick */
  /* content */
}))
