using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _4
{
  class Program
  {
    static void ListMethods(object obj)
    {
      
    }

    static void Main(string[] args)
    {
      object obj = new Foo();
      var methods = obj.GetType().GetMethods();
      foreach (var methodInfo in methods)
      {
        if (methodInfo.IsPublic && !methodInfo.IsStatic && methodInfo.ReturnType == typeof(int) && methodInfo.GetParameters().Length == 0)
        {
          if (methodInfo.GetCustomAttributes(typeof(OznakowaneAttribute), false).Length > 0)
            Console.WriteLine(methodInfo.Name);
        }
      }
      Console.ReadLine();
    }

  }

  class Foo
  {
    [Oznakowane]
    public int Bar()
    {
      return 1;
    }

    public int Qux()
    {
      return 2;
    }
  }

  class OznakowaneAttribute : Attribute
  {
  }
}
