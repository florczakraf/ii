using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace l4
{
  public class Airplane
  {
    public void Clean()
    {

    }
  }

  public class NoAirplanesException : Exception
  {
    public NoAirplanesException(String s) : base() { }
  }

  public class Airport
  {
    private static List<Airplane> _available = new List<Airplane>();
    private static List<Airplane> _used = new List<Airplane>();

    public Airplane getAirplane()
    {
      lock (_available)
      {
        if (_available.Count != 0)
        {
          Airplane airplane = _available.First();
          _used.Add(airplane);
          _available.RemoveAt(0);
          return airplane;
        }
        else
        {
          throw new NoAirplanesException("There are no more planes!");
        }
      }
    }

    public void releaseAirplane(Airplane airplane)
    {
      airplane.Clean();

      lock (_available)
      {
        _available.Add(airplane);
        _used.Remove(airplane);
      }
    }

    public Airport(int pool)
    {
      while (pool > 0)
      {
        _available.Add(new Airplane());
        pool--;
      }
    }
  }
}
