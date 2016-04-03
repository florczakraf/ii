// Przed
public class ReportPrinter
{
  public string GetData(Report r)
  {
    return r.GetData();
  }
  
  public void FormatDocument(Report r)
  {
    r.Justify();
    r.Paginate();
  }
  
  public void PrintReport(Report r)
  {
    string data = r.GetData();
    Console.Write(data);
  }
}

// Po

public class ReportPrinter
{
  Report r;
  
  void PrintReport()
  {
    string data = r.GetData();
    data = Formatter.Justify(data);
    data = Formatter.Paginate(data);
    Console.Write(data);
  }
}

public class Report
{
  private string data;
  
  public string GetData()
  {
    return data;
  }
  
  public void SetData(string data)
  {
    this.data = data;
  }
}

class Formatter
{
  public static void Justify(string data)
  {
    // cośtam
    return data;
  }
  
  public static void Paginate(string data)
  {
    // cośtam
    return data;
  }
}

