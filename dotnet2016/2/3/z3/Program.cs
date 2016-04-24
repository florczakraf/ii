using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace z3
{
  class Program
  {
    static void Main(string[] args)
    {
      List<int> list = new List<int>() { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };

      Console.Write("List: ");
      PrintList(list);

      Console.Write("ConvertAll [i => i.ToString()]: ");
      PrintList(list.ConvertAll(i => i.ToString()));

      Console.Write("FindAll [i => i % 3 == 0]: ");
      PrintList(list.FindAll(i => i % 3 == 0));

      Console.Write("ForEach [Write]: ");
      list.ForEach(i => Console.Write("{0}, ", i));
      Console.WriteLine();

      Console.Write("RemoveAll [i => i % 4 == 0]: ");
      list.RemoveAll(i => i % 4 == 0);
      PrintList(list);

      Console.Write("Sort [descending]: ");
      list.Sort((a, b) => b.CompareTo(a));
      PrintList(list);

      Console.ReadKey();
    }

    static void PrintList<T>(List<T> list)
    {
      foreach (var i in list)
      {
        Console.Write("{0}, ", i);
      }
      Console.WriteLine();
    }

  }
}
