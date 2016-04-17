using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace z2
{
  class Program
  {
    [DllImport("isPrimeC.dll", EntryPoint = "IsPrimeC")]
    public static extern bool IsPrimeC(int x);

    static void Main(string[] args)
    {
      int x;
      Console.Write("Enter number: ");
      x = int.Parse(Console.ReadLine());
      Console.WriteLine("Is {0} prime? {1}", x, IsPrimeC(x));
      Console.ReadKey();
    }
  }
}
