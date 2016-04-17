using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace _3
{
  class Program
  {
    static void Main(string[] args)
    {
      Class c = new Class(5);
      int result = 0;
      int times = 10000000;

      DateTime start = DateTime.Now;

      for (int i = 0; i < times; i++)
      {
        MethodInfo add = c.GetType().GetMethod("Add", BindingFlags.Instance | BindingFlags.NonPublic);
        result = (int)add.Invoke(c, new object[] { (int)1, (int)1 });

      }

      Console.WriteLine(result);
      DateTime end = DateTime.Now;
      TimeSpan elapsed = end - start;
      Console.WriteLine("[Reflection Add] Elapsed time: {0}", elapsed);

      start = DateTime.Now;

      for (int i = 0; i < times; i++)
      {
        MethodInfo data = c.GetType().GetProperty("Data", BindingFlags.NonPublic | BindingFlags.Instance).GetGetMethod(true);
        result = (int)data.Invoke(c, null);
      }

      Console.WriteLine(result);
      end = DateTime.Now;
      elapsed = end - start;
      Console.WriteLine("[Reflection Property] Elapsed time: {0}", elapsed);

      c.RunAdd(1, 1, times);
      c.TestProperty(times);

      Console.ReadLine();
    }
  }

  class Class
  {
    public Class(int d)
    {
      Data = d;
    }

    private int Data { get; set; }

    private int Add(int a, int b)
    {
      return a + b;
    }

    public void RunAdd(int a, int b, int times)
    {
      int result = 0;
      DateTime start = DateTime.Now;

      for (int i = 0; i < times; i++)
      {
        result = Add(a, b);
      }

      Console.WriteLine(result);
      DateTime end = DateTime.Now;
      TimeSpan elapsed = end - start;
      Console.WriteLine("[RunAdd] Elapsed time: {0}", elapsed);
    }
    public void TestProperty(int times)
    {
      int result = 0;
      DateTime start = DateTime.Now;
      for (int i = 0; i < times; i++)
      {
        result = Data;
      }
      Console.WriteLine(result);
      DateTime end = DateTime.Now;
      TimeSpan elapsed = end - start;
      Console.WriteLine("[TestProperty] Elapsed time: {0}", elapsed);

    }
  }
}
