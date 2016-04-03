// Przed
public class TaxCalculator
{
  public Decimal CalculateTax(Decimal Price)
  {
    return Price * 0.22;
  }
}

public class Item 
{
  private string _Name;
  private Decimal _Price;
  
  public Decimal Price
  {
    get { return _Price; }
  }
  
  public string Name
  { 
    get { return _Name; } 
  }
}

public class CashRegister 
{
  public TaxCalculator taxCalc = new TaxCalculator();
  
  public Decimal CalculatePrice(Item[] Items)
  {
    Decimal _price = 0;
    foreach (Item item in Items)
    {
      _price += item.Price + taxCalc.CalculateTax(item.Price);
    }
    
    return _price;
  }

  public string PrintBill(Item[] Items)
  {
    foreach (var item in Items)
      Console.WriteLine( "towar {0} : cena {1} + podatek {2}",
        item.Name, item.Price, taxCalc.CalculateTax(item.Price));
  }
}

// Po

abstract class AbstractTaxCalculator
{
  abstract public Decimal CalculateTax(Decimal Price);
}

class BasicTaxCalculator : AbstractTaxCalculator
{
  override public Decimal CalculateTax(Decimal Price)
  {
    return Price * 0.22;
  }
}

class Item
{
  private string _Name;
  private Decimal _Price;
  private AbstractTaxCalculator _TaxCalculator;
  
  public Item(string name, decimal price, AbstractTaxCalculator calc)
  {
    this._Name = name;
    this._Price = price;
    this._TaxCalculator = calc;
  }
  
  public Decimal Tax
  {
    get { return _TaxCalculator.CalculateTax(Price); }
  }
  
  public Decimal Price
  {
    get { return _Price; }
  }
  
  public string Name
  { 
    get { return _Name; } 
  }
}

class CashRegister
{
  public Decimal CalculatePrice(Item[] items)
  {
    Decimal _price = 0;
    foreach (Item item in Items)
    {
      _price += item.Price + item.Tax;
    }
    
    return _price;
  }
  
  public void PrintBill(Item[] items, string order = "")
  {
    switch(order)
    {
      case "alphabetical":
        // odpowiednie sortowanie
        _PrintItems(items);
        break;
      case "category":
        // odpowiednie sortowanie
        _PrintItems(items);
        break;
      default:
        // odpowiednie sortowanie
        _PrintItems(items);
        break;
    }
  }
  
  private void _PrintItems(Item[] items)
  {
    foreach (Item item in items)
      Console.WriteLine("towar {0} : cena {1} + podatek {2}",
        item.Name, item.Price, item.Tax);
  }
}

