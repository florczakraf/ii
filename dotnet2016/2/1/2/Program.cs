using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _2
{
  class Program
  {
    static void Main(string[] args)
    {
      Grid grid = new Grid(4, 4);
      grid[2, 2] = 5;
      int elem = grid[1, 3];
      int elem2 = grid[2, 2];
      int[] line = grid[2];
      Console.WriteLine("elem: {0} elem2: {1}", elem, elem2);
      foreach (int i in line)
      {
        Console.WriteLine(i);
      }
      
      Console.ReadLine();
    }
  }

  /// <summary>
  /// Class with indexer
  /// </summary>
  public class Grid
  {
    int[][] _grid;

    /// <summary>
    /// Constructor for Grid
    /// </summary>
    /// <param name="x">number of rows</param>
    /// <param name="y">number of colums</param>
    public Grid(int x, int y)
    {
      _grid = new int[x][];

      for (int i = 0; i < x; i++)
      {
        _grid[i] = new int[y];
      }
    }

    /// <summary>
    /// 1-dimensional indexer for getting rows or grid
    /// </summary>
    /// <param name="x">number of row to get</param>
    /// <returns></returns>
    public int[] this[int x]
    {
      get
      {
        return this._grid[x];
      }
    }

    
    /// <summary>
    /// 2-dimensional indexer for getting and setting cells of grid
    /// </summary>
    /// <param name="x">number of row</param>
    /// <param name="y">number of column</param>
    /// <returns></returns>
    public int this[int x, int y]
    {

      get
      {
        return this._grid[x][y];
      }
      set
      {
        this._grid[x][y] = value;
      }
    }
  }
}
