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
      Airport airport = new Airport(10);
      LogProxyAirport logProxy = new LogProxyAirport(airport);

      Airplane a1 = logProxy.getAirplane();
      Airplane a2 = logProxy.getAirplane();
      Airplane a3 = logProxy.getAirplane();

      logProxy.releaseAirplane(a2);
      logProxy.releaseAirplane(a3);
      logProxy.releaseAirplane(a1);

      Console.ReadKey();
    }

    public class ProtectionProxyAirport
    {
      private Airport _airport;

      public ProtectionProxyAirport(Airport airport)
      {
        this._airport = airport;
      }

      public Airplane getAirplane()
      {
        if (checkHour())
        {
          return _airport.getAirplane();
        }
        else
          throw new ClosedAirportException("The airport is closed now.");
      }

      public void releaseAirplane(Airplane airplane)
      {
        if (checkHour())
        {
          _airport.releaseAirplane(airplane);
        }
        else
          throw new ClosedAirportException("The airport is closed now.");
      }


      bool checkHour()
      {
        TimeSpan now = DateTime.Now.TimeOfDay;
        TimeSpan start = new TimeSpan(8, 0, 0);
        TimeSpan end = new TimeSpan(22, 0, 0);
        return (now >= start && now <= end);
      }

    }


    public class LogProxyAirport
    {
      private Airport _airport;

      public LogProxyAirport(Airport airport)
      {
        this._airport = airport;
      }

      public Airplane getAirplane()
      {
        Console.WriteLine("[{0}] Method: getAirplane, arguments: none", DateTime.Now);

        Airplane a = _airport.getAirplane();

        Console.WriteLine("[{0}] Method: getAirplane, returns: {1}", DateTime.Now, a);
        return a;
      }

      public void releaseAirplane(Airplane airplane)
      {
        Console.WriteLine("[{0}] Method: releaseAirplane, arguments: {1}", DateTime.Now, airplane);

        _airport.releaseAirplane(airplane);

        Console.WriteLine("[{0}] Method: releaseAirplane, returns: void", DateTime.Now);
      }
    }




    public class Airport
    {
      private static List<Airplane> _available = new List<Airplane>();
      private static List<Airplane> _inUse = new List<Airplane>();

      public Airplane getAirplane()
      {
        lock (_available)
        {
          if (_available.Count != 0)
          {
            Airplane airplane = _available.First();
            _inUse.Add(airplane);
            _available.RemoveAt(0);
            return airplane;
          }
          else
          {
            throw new NoAirplanesException("Airport ran out of planes!");
          }
        }
      }

      public void releaseAirplane(Airplane airplane)
      {
        airplane.CleanUp();

        lock (_available)
        {
          _available.Add(airplane);
          _inUse.Remove(airplane);
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

    public class Airplane
    {
      public void CleanUp()
      {

      }
    }

    public class NoAirplanesException : Exception
    {
      public NoAirplanesException(String s) : base() { }
    }

    public class ClosedAirportException : Exception
    {
      public ClosedAirportException(String s) : base() { }
    }
  }
}
