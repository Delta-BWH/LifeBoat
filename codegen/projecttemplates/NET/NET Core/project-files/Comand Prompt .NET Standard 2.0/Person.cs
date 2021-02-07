using System;
using Weborb.Service;

namespace Comand_Prompt_.NET_Standard_2._0
{
  public class Person
  {
    [SetClientClassMemberName( "objectId" )]
    public String ObjectId { get; set; }
    public String Name { get; set; }
    public Int32? Age { get; set; }

    public Person()
    {
    }

    public Person( String name, Int32? age )
    {
      Name = name;
      Age = age;
    }
  }
}
