import cgi, textwrap

class HtmlObject(object):
  def html(self):
    html_str = ""
    for field in self.__dict__:
      html_str += "<p>" + field + " <i>" + cgi.escape(str(eval("self.%s.__class__" % field)))
      html_str += "</i>: <b>" + str(eval("self.%s" % field)) + "</b></p>\n"
    return html_str

  def html_page(self):
    html_code = textwrap.dedent("""
                <html lang="en" dir="ltr">
                  <head>
                    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                    <title>Object's fields</title>
                  </head>
                  <body>
                    %s
                  </body>
                </html>
                """) % self.html()
    return html_code

class TestSubclass(HtmlObject):
  def __init__(self):
    self.secret_variable = 'value'
    
def main():
  obj = HtmlObject()
  obj2 = TestSubclass()
  obj.field1 = "this one is string"
  obj.another = 4.2
  obj.integer = 1337

  
  print(obj.html())
  print()
  print(obj.html_page())
  print()
  print(obj2.html_page())
  
  


if __name__ == '__main__':
  main()