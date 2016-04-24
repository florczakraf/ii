using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace z2
{
  class Program
  {
    static void Main(string[] args)
    {
      Context context = new Context();
      context.SetValue("x", false);
      // (x && true) || (false || !y)
      AbstractExpression exp = new Or(new And(new Var("x"), new Const(true)), new Or(new Const(false), new Not(new Var("y"))));

      try
      {
        bool value = exp.Interpret(context);
        Console.WriteLine("Value: {0}", value);
      }
      catch (KeyNotFoundException)
      {
        Console.WriteLine("[!] Unbound variable");
      }

      context.SetValue("y", true);

      try
      {
        bool value = exp.Interpret(context);
        Console.WriteLine("Value of expression: {0}", value);
      }
      catch (KeyNotFoundException)
      {
        Console.WriteLine("[!] Unbound variable");
      }

      Console.ReadKey();
    }

    public class Context
    {
      private Dictionary<string, bool> _dict = new Dictionary<string, bool>();

      public bool GetValue(string var)
      {
        if (this._dict.ContainsKey(var))
          return this._dict[var];
        else throw new KeyNotFoundException();
      }

      public void SetValue(string var, bool val)
      {
        if (!this._dict.ContainsKey(var))
          this._dict.Add(var, val);
        else
          this._dict[var] = val;
      }
    }

    public abstract class AbstractExpression
    {
      public abstract bool Interpret(Context context);
    }

    public class Var : AbstractExpression
    {
      private string _name;

      public Var(string name)
      {
        this._name = name;
      }

      public override bool Interpret(Context context)
      {
        return context.GetValue(this._name);
      }
    }

    public class Const : AbstractExpression
    {
      private bool _value;

      public Const(bool val)
      {
        this._value = val;
      }

      public override bool Interpret(Context context)
      {
        return this._value;
      }
    }

    // Binary

    public abstract class BinaryExpression : AbstractExpression
    {
      protected AbstractExpression _e1, _e2;

      public BinaryExpression(AbstractExpression e1, AbstractExpression e2)
      {
        this._e1 = e1;
        this._e2 = e2;
      }
    }

    public class Or : BinaryExpression
    {
      public Or(AbstractExpression e1, AbstractExpression e2) : base(e1, e2) { }

      public override bool Interpret(Context context)
      {
        return _e1.Interpret(context) || _e2.Interpret(context);
      }
    }

    public class And : BinaryExpression
    {
      public And(AbstractExpression e1, AbstractExpression e2) : base(e1, e2) { }

      public override bool Interpret(Context context)
      {
        return _e1.Interpret(context) && _e2.Interpret(context);
      }
    }
    
    // Unary

    public abstract class UnaryExpression : AbstractExpression
    {
      protected AbstractExpression _e;

      public UnaryExpression(AbstractExpression e)
      {
        this._e = e;
      }
    }

    public class Not : UnaryExpression
    {
      public Not(AbstractExpression e) : base(e) { }

      public override bool Interpret(Context context)
      {
        return !_e.Interpret(context);
      }
    }


  }
}
