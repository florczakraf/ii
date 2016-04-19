using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace z4
{
  class Program
  {
    static void Main(string[] args)
    {
      ArrayList a = new ArrayList() { 1, 5, 3, 3, 2, 4, 3 };

      /* the ArrayList's Sort method accepts ONLY an IComparer */
      a.Sort(new Adapter<int>(IntComparer));

      foreach (int i in a)
        Console.Write("{0} ", i);

      Console.ReadKey();
    }

    public static int IntComparer(int x, int y)
    {
      return x.CompareTo(y);
    }

    class Adapter<T> : IComparer
    {
      private Comparison<T> _comparison;

      public Adapter(Comparison<T> c)
      {
        this._comparison = c;
      }

      public int Compare(object x, object y)
      {
        return _comparison((T)x, (T)y);
      }
    }

  }
}
