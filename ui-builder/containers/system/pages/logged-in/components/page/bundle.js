define([], () => ({
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
