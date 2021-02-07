using BackendlessAPI;
using BackendlessAPI.RT.Messaging;
using System;
using System.Threading.Tasks;
using Weborb.Util.Logging;

namespace RealTimeChat
{
  public static class RTMessageServiceConnector
  {
    public static void ConnectRT()
    {
      Log.stopLogging( Backendless.BACKENDLESSLOG );

      Task.Run( () =>
      {
        IChannel channel = Backendless.Messaging.Subscribe( "chat" );
        MessageReceived<String> messageListener = ( message ) =>
        {
          Console.ForegroundColor = ConsoleColor.Green;

          if( ChatActivity.trueLog != false )
            Console.WriteLine( $"\t\t\t\t\t{message}" );
          else
          {
            Console.WriteLine( $"\t\t\t\t\t{message}" );
            ChatActivity.trueLog = true;        
          }
          Console.ForegroundColor = ConsoleColor.DarkGray;
          Console.WriteLine( "\t\t\t\t\tIf you want to stop press <Escape>" );
          Console.ResetColor();
        };

        channel.AddMessageListener( messageListener );
      } );
    }
  }
}
