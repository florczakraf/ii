using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _1
{
  class Program
  {
    static void Main(string[] args)
    {
      List<int> Numbers = new List<int>();

      for (int i = 1; i <= 100000; i++)
      {
        Number current = new Number(i);

        if (i % current.DigitsSum() == 0 && current.divisibleByAllDigits())
        {
          Numbers.Add(i);
        }
      }

      for (int i = 0; i < Numbers.Count; i++)
      {
        Console.WriteLine(Numbers[i]);
      }
      Console.ReadLine();
    }
  }

  class Number
  {
    public int Value { get; set; }

    public Number(int v)
    {
      this.Value = v;
    }

    public List<int> Digits()
    {
      List<int> digits = new List<int>();
      int n = Value;

      while (n > 0)
      {
        digits.Add(n % 10);
        n = n / 10;
      }

      return digits;
    }

    public int DigitsSum()
    {
      return Digits().Sum();
    }

    public bool divisibleByAllDigits()
    {
      return Digits().All(digit => digit != 0 && Value % digit == 0);
    }
  }

}
