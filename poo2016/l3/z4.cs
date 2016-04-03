abstract class Shape
{
  abstract public int CalculateArea();
}

class Rectangle : Shape
{
  private int width, height;
  
  override public int CalculateArea()
  {
    return width * height;
  }
  
  public Rectangle(int w, int h)
  {
    this.width = w;
    this.height = h;
  }
}

class Square : Shape
{
  private int width;
  
  override public int CalculateArea()
  {
    return width * width;
  }
  
  public Rectangle(int w)
  {
    this.width = w;
  }
}