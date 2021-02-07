using System;
using Weborb.Service;

namespace XamarinMobile
{
  public class Person
  {
    [SetClientClassMemberName( "objectId" )]
    public String ObjectId { get; set; }
    public String Name { get; set; }
    public Int32 Age { get; set; }

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
