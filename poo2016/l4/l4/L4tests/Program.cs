using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using l4;
using NUnit.Framework;
using System.Threading;

namespace L4tests
{
  [TestFixture]
  public class Z1Tests
  {
    [Test]
    public void Singleton1Test()
    {
      Singleton1 s1, s2;
      s1 = s2 = null;

      Thread t1 = new Thread(() => { s1 = Singleton1.GetInstance(); });
      Thread t2 = new Thread(() => { s2 = Singleton1.GetInstance(); });

      t1.Start();
      t2.Start();

      t1.Join();
      t2.Join();

      Assert.AreEqual(s1, s2);
    }

    [Test]
    public void Singleton2Test()
    {
      Singleton2 s1, s2;
      s1 = s2 = null;

      Thread t1 = new Thread(() => { s1 = Singleton2.GetInstance(); });
      Thread t2 = new Thread(() => { s2 = Singleton2.GetInstance(); });

      t1.Start();
      t2.Start();

      t1.Join();
      t2.Join();

      Assert.AreNotEqual(s1, s2);
    }

    [Test]
    public void Singleton3Test()
    {
      Singleton3 s1, s2, s3;
      s1 = Singleton3.GetInstance();
      Thread.Sleep(2000);
      s2 = Singleton3.GetInstance();
      Thread.Sleep(4000);
      s3 = Singleton3.GetInstance();

      Assert.AreEqual(s1, s2);
      Assert.AreNotEqual(s2, s3);
    }
  }

    [TestFixture]
  public class Z3Tests
  {
    [Test]
    public void GetAirplaneTest()
    {
      Airport airport = new Airport(3);
      Airplane a1 = airport.getAirplane();
      Airplane a2 = airport.getAirplane();
      Airplane a3 = airport.getAirplane();

      Assert.AreNotEqual(a1, a2);
      Assert.AreNotEqual(a2, a3);
    }

    [Test]
    public void GetAirplaneEmptyPoolTest()
    {
      Airport airport = new Airport(1);
      Airplane a1 = airport.getAirplane();

      Assert.That(airport.getAirplane, Throws.TypeOf<l4.NoAirplanesException>());
    }

    [Test]
    public void ReleaseAirplanceTest()
    {
      Airport airport = new Airport(1);
      Airplane a1 = airport.getAirplane();
      Airplane a2 = a1;

      airport.releaseAirplane(a1);
      a1 = airport.getAirplane();
      Assert.AreEqual(a1, a2);
    }
  }

 }
