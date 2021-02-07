using BackendlessAPI;
using System;
using System.Collections.Generic;
using BackendlessAPI.Persistence;
using System.Threading.Tasks;

namespace CRUD
{
  static class OperationsCRUD
  {
    public static void Create( String tableName)
    {
      try
      {
        Dictionary<String, Object> obj = new Dictionary<String, Object>();
        obj["Age"] = new Random().Next( 2, 50 );
        obj["Name"] = HelperCRUD.RandomString( new Random().Next( 3, 16 ) );
        Backendless.Data.Of($"{tableName}").Save( obj );
      }
      catch( Exception e )
      {
        throw new Exception( e.Message );
      }
    }

    public static async void CreateAsync( String tableName)
    {
      try
      {
        Dictionary<String, Object> obj = new Dictionary<String, Object>();
        obj[ "Age" ] = new Random().Next( 2, 50 );
        obj[ "Name" ] = HelperCRUD.RandomString( new Random().Next( 3, 16 ) );
        await Backendless.Data.Of($"{tableName}").SaveAsync( obj );
      }
      catch( Exception e )
      {
        throw new Exception( e.Message );
      }
    }

    public static void Update( String tableName )
    {
      try
      {
        Dictionary<String, Object> obj = Backendless.Data.Of($"{tableName}").FindFirst();
        obj["Age"] = new Random().Next( 2, 50 );
        obj["Name"] = HelperCRUD.RandomString( new Random().Next( 3, 16 ) );
        Backendless.Data.Of($"{tableName}").Save( obj );
      }
      catch( Exception e )
      {
        throw new Exception( e.Message );
      }
    }

    public static async void UpdateAsync( String tableName )
    {
      try
      {
        Dictionary<String, Object> obj = Backendless.Data.Of($"{tableName}").FindFirst();
        obj["Age"] = new Random().Next( 2, 50 );
        obj["Name"] = HelperCRUD.RandomString( new Random().Next( 3, 16 ) );
        await Backendless.Data.Of($"{tableName}").SaveAsync( obj );
      }
      catch( Exception e )
      {
        throw new Exception( e.Message );
      }
    }

    public static IList<Dictionary<String, Object>> Find( String tableName )
    {
      try
      {
        return Backendless.Data.Of($"{tableName}").Find();
      }
      catch( Exception e )
      {
        throw new Exception( e.Message );
      }
    }

    public static async Task<IList<Dictionary<String, Object>>> FindAsync( String tableName )
    {
      try
      {
        return await Backendless.Data.Of($"{tableName}").FindAsync();
      }
      catch( Exception e )
      {
        throw new Exception( e.Message );
      }
    }
    public static Dictionary<String, Object> FindFirst( String tableName )
    {
      try
      {
        return Backendless.Data.Of($"{tableName}").FindFirst();
      }
      catch( Exception e )
      {
        throw new Exception( e.Message );
      }
    }

    public static async Task<Dictionary<String, Object>> FindFirstAsync( String tableName )
    {
      try
      {
        return await Backendless.Data.Of($"{tableName}").FindFirstAsync();
      }
      catch( Exception e )
      {
        throw new Exception( e.Message );
      }
    }

    public static Dictionary<String, Object> FindLast( String tableName )
    {
      try
      {
        return Backendless.Data.Of($"{tableName}").FindLast();
      }
      catch( Exception e )
      {
        throw new Exception( e.Message );
      }
    }

    public static async Task<Dictionary<String, Object>> FindLastAsync( String tableName )
    {
      try
      {
        return await Backendless.Data.Of("tableName").FindLastAsync();
      }
      catch( Exception e )
      {
        throw new Exception( e.Message );
      }
    }

    public static IList<Dictionary<String, Object>> FindWithSort( String tableName, String sortBy )
    {
      try
      {
        return Backendless.Data.Of($"{tableName}")
                            .Find( DataQueryBuilder.Create().AddSortBy( sortBy ) );
      }
      catch( Exception e )
      {
        throw new Exception( e.Message );
      }
    }

    public static async Task<IList<Dictionary<String, Object>>> FindWithSortAsync( String tableName, String sortBy )
    {
      try
      {
        return await Backendless.Data.Of($"{tableName}")
                            .FindAsync( DataQueryBuilder.Create().AddSortBy( sortBy ) );
      }
      catch( Exception e )
      {
        throw new Exception( e.Message );
      }
    }

    public static void Delete( String tableName )
    {
      Backendless.Data.Of($"{tableName}").Remove( Backendless.Data.Of($"{tableName}").FindFirst() );
    }

    public static async void DeleteAsync( String tableName )
    {
      await Backendless.Data.Of($"{tableName}").RemoveAsync( Backendless.Data.Of($"tableName").FindFirst() );
    }
  }
}
