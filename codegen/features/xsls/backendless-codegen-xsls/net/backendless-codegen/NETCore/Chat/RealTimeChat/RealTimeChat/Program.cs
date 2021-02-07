using System;

namespace RealTimeChat
{
  class Program
  {
    static void Main( string[] args )
    {
      Console.Title = "Real-time chat";
      InitializerAPI.InitializeAPI();
      RTMessageServiceConnector.ConnectRT();
      ChatActivity.StartChat();
    }
  }
}
