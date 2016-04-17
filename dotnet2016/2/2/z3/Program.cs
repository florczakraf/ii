using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace z3
{
  class Program
  {
    [DllImport("executeC.dll", EntryPoint = "ExecuteC")]
    public static extern int ExecuteC(int x, [MarshalAs(UnmanagedType.FunctionPtr)]intdel f);

    static void Main(string[] args)
    {
      int x;
      Console.Write("Enter number: ");
      x = int.Parse(Console.ReadLine());
      Console.WriteLine("Is {0} prime? {1}", x, ExecuteC(x, IsPrimeCs));
      Console.ReadKey();
    }

    [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
    public delegate int intdel(int x);

    static int IsPrimeCs(int x)
    {
      int i;
      for (i = 2; i <= x - 1; i++)
        if (x % i == 0)
          return 0;

      if (i == x)
        return 1;

      return 0;
    }
  }
}
