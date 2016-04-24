using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace z1
{
  class Program
  {
    static void Main(string[] args)
    {
      ILogger logger1 = LoggerFactory.Instance.GetLogger(LogType.File, Path.GetTempFileName());
      logger1.Log("foo bar");

      ILogger logger2 = LoggerFactory.Instance.GetLogger(LogType.None);
      logger2.Log("bar bar");

      ILogger logger3 = LoggerFactory.Instance.GetLogger(LogType.Console);
      logger3.Log("qux");

      Console.ReadKey();

    }

    public interface ILogger
    {
      void Log(string message);
    }

    public class FileLogger : ILogger
    {
      private string _path;

      public void Log(string message)
      {
        using (StreamWriter sw = new StreamWriter(this._path, true))
        {
          sw.WriteLine(message);
        }
      }

      public FileLogger(string path)
      {
        this._path = path;
      }
    }

    public class ConsoleLogger : ILogger
    {
      public void Log(string message)
      {
        Console.WriteLine(message);
      }
    }

    public class NullObject : ILogger
    {
      public void Log(string message)
      {

      }
    }

    public enum LogType { None, Console, File };

    public class LoggerFactory
    {
      private static LoggerFactory _instance = null;

      public ILogger GetLogger(LogType logType, string arg = null)
      {
        switch (logType)
        {
          case LogType.None:
            return new NullObject();
          case LogType.Console:
            return new ConsoleLogger();
          case LogType.File:
            return new FileLogger(arg);
          default:
            return new NullObject();
        }
      }

      public static LoggerFactory Instance
      {
        get
        {
          if (_instance == null)
          {
            lock (typeof(LoggerFactory))
            {
              _instance = new LoggerFactory();
            }
          }

          return _instance;
        }
      }
    }

  }
}
