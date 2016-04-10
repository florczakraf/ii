class A {}

class B  // Creator
{
  A a;
  
  public B()
  {
    a = new A();
  }
}

////////////////////////

class Item
{
  public int a;
  public string b;
}

class Order  // Information expert
{
  List<Item> items;
  
  public int getNumberOfItems() // klasa Order ma wszystkie informacje potrzebne do
                         // oblicznia liczby przedmiotów, zatem jest miejscem na tę funkcję
  {
    // kod obliczający liczbę przedmiotów w zamówieniu
  }
}

////////////////////////

class A
{
  public int action()
  {
    return 1;
  }
}

class Controller  // Controller :), Indirection (bo Controller oddziela UI od innych klas)
{
  A a;
  
  public int performAction()  // wywołanie spowodowane sygnałem wysłanym z UI
  {
    return a.performAction();  // oddelegowanie zadania i zwrócenie wyniku do UI
  }
}

//////////////////////

abstract class Shape // Polymorphism
{
  abstract public float getArea();
}

class Square : Shape
{
  public int a;
  
  override public float getArea()
  {
    return a * a;
  }
}

class Rectangle : Shape
{
  public int a, b;
  
  override public float getArea()
  {
    return a * b;
  }
}
