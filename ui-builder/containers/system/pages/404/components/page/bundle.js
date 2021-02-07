define([], () => ({
  /* content */

  /* handler:onEnter */
  async onEnter(___arguments) {
      ___arguments.context.pageData['error'] = null;
  ___arguments.context.pageData['user'] = (
      await (async function(userIdentity){
        var userColumns = await Backendless.UserService.describeUserClass()
        var identityColumn = userColumns.find(column => column.identity)
        var whereClause = `${identityColumn.name} = '${userIdentity}'`
        var query = Backendless.DataQueryBuilder.create().setWhereClause(whereClause)
        var users = await Backendless.Data.of(Backendless.User).find(query)

        return users[0]
     })((___arguments.context.pageData['userIdentity']))
  );

  },  
/* handler:onEnter *//* content */
}));
