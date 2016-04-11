using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Timers;

namespace l4
{
  public class Singleton1
  {
    private static Singleton1 _instance = null;

    public static Singleton1 GetInstance()
    {
      lock (typeof(Singleton1))
      {
        if (_instance == null)
          _instance = new Singleton1();
      }
      return _instance;
    }

    protected Singleton1() { }
  }

  public class Singleton2
  {
    [ThreadStatic]
    private static Singleton2 _instance = null;

    public static Singleton2 GetInstance()
    {
      lock (typeof(Singleton2))
      {
        if (_instance == null)
          _instance = new Singleton2();
      }
      return _instance;
    }

    protected Singleton2() { }
  }

  public class Singleton3
  {
    private static Singleton3 _instance = null;
    private static Timer _timer;

    public static Singleton3 GetInstance()
    {
      if (_instance == null)
      {
        _instance = new Singleton3();

        _timer = new Timer();
        _timer.Elapsed += _timer_Elapsed;
        _timer.Interval = 5000;
        _timer.Enabled = true;
      }

      return _instance;
    }

    protected Singleton3() { }

    private static void _timer_Elapsed(object sender, ElapsedEventArgs e)
    {
      _instance = null;
    }
  }

}
