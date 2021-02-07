using System;
using BackendlessAPI;
using BackendlessAPI.RT.Data;

namespace Comand_Prompt_.NET_Standard_2._0
{
  class Program
  {
    static void Main( String[] args )
    {
      try
      {
        InitializerAPI.InitAPI();
        IEventHandler<Person> eventHandler = Backendless.Data.Of<Person>().RT();

        eventHandler.AddCreateListener( createdObject =>
        {
          Console.WriteLine( $"Person object has been created. Object Id - { createdObject.ObjectId }" );
        } );

        Backendless.RT.AddConnectErrorListener( ( fault ) =>
        {
          Console.WriteLine( $"Connection error. {fault}" );
        } );

        Backendless.RT.AddConnectListener( () =>
        {
          Backendless.Data.Of<Person>().Save( new Person( "Joe", 21 ) );
        } );
      }
      catch( Exception e)
      {
        Console.WriteLine( "An error occurred during the operation" + e );
      }

      Console.ReadKey();
    }
  }
}
