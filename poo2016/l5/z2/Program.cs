﻿using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace z2
{
  class Program
  {
    static void Main(string[] args)
    {

      byte[] array = Encoding.ASCII.GetBytes("test\0");

      string tempFile = Path.GetTempPath() + "rf.z2.txt";

      FileStream fileToWrite = File.Create(tempFile);
      CaesarStream caeToWrite = new CaesarStream(fileToWrite, 5);

      FileStream defaultReader = new FileStream(tempFile, FileMode.Open);

      byte[] array2 = new byte[5];

      defaultReader.Read(array2, 0, 4);

      Console.WriteLine(Encoding.ASCII.GetString(array2));
    }
  }

  public class CaesarStream
  {
    private int _shift;
    private Stream _stream;

    public CaesarStream(Stream stream, int shift)
    {
      this._stream = stream;
      this._shift = shift;
    }

    public void Write(byte[] array, int offset, int count)
    {
      byte[] newArray = array.Select(Encode).ToArray();
      
      _stream.Write(newArray, offset, count);
    }

    private byte Encode(byte b)
    {
      return byte.Parse(((int.Parse(b.ToString()) + _shift) % (byte.MaxValue + 1)).ToString());
    }

    public int Read(byte[] array, int offset, int count)
    {
      int number = _stream.Read(array, offset, count);

      for (int i = offset; i < offset + number; i++)
        array[i] = Encode(array[i]);

      return number;  // ile odczytano
    }
  }
}