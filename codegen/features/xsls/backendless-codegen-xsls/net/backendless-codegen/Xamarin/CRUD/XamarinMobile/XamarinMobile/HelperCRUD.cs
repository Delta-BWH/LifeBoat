using  System;
using  System.Linq;
using System.Collections.Generic;
using System.Reflection;

namespace XamarinMobile
{
  public static class HelperCRUD
  {
    public static string RandomString( int length )
    {
      const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
      return new string( Enumerable.Repeat( chars, length )
          .Select( s => s[ new Random().Next( s.Length ) ] ).ToArray() );
    }

    public static Dictionary<String, Object> CastFrom( Object obj )
    {
      return obj.GetType().GetProperties( BindingFlags.Instance | BindingFlags.Public )
         .ToDictionary( prop => prop.Name, prop => prop.GetValue( obj, null ) );
    }

    public static List<Dictionary<String, Object>> BulkCastFrom<E>( List<E> obj )
    {
      List<Dictionary<String, Object>> listMaps = new List<Dictionary<String, Object>>();
      foreach( var entry in obj )
        listMaps.Add( CastFrom( entry ) );

      return listMaps;
    }
  }
}