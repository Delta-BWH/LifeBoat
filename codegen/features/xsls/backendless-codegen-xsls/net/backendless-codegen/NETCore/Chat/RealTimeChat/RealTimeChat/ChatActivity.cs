using BackendlessAPI;
using System;

namespace RealTimeChat
{
  public static class ChatActivity
  {
    internal static Boolean trueLog = true;
    internal static String userNickname;
    public static void StartChat()
    {
      Console.WriteLine( "Note:\tPress <Enter> to start or <Escape> to stop" );
      ConsoleKey KeyButton = Console.ReadKey( true ).Key;

      if( KeyButton == ConsoleKey.Enter )
      {
        Console.Write( "Note:\tEnter your nickname: " );
        trueLog = false;
        userNickname = Console.ReadLine();
        Backendless.Messaging.Publish( userNickname + " joined", "chat" );
        Console.WriteLine( "Note:\tAfter anyone message press <Enter> to continue" );

        while( KeyButton != ConsoleKey.Escape )
        {
          System.Threading.Thread.Sleep( 200 );
          Console.Write( "-->" );
          Backendless.Messaging.Publish( userNickname + ": " + Console.ReadLine(), "chat" );
          KeyButton = Console.ReadKey( true ).Key;
        };
      }
    }
  }
}
