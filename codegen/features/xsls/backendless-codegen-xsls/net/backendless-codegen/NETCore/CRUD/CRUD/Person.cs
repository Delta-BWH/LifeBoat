using System;
using Weborb.Service;

namespace CRUD
{
  public class Person
  {
    [SetClientClassMemberName( "objectId" )]
    public String ObjectId { get; set; }
    public virtual String Name { get; set; }
    public virtual Int32 Age { get; set; }

    public Person()
    {
    }

    public Person( String name, Int32 age )
    {
      Age = age;
      Name = name;
    }
  }
}
