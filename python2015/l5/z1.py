from urllib.request import urlopen
import re
import queue

class Traversal:
  def __init__(self, max_depth, func):
    self.func = func
    self.max_depth = max_depth
    self.queue = queue.Queue()
    self.visited = set()

  def traverse(self, url, depth = 1):
    page = urlopen(url).read().decode('utf-8')
    
    if depth == 1:
      self.visited.add(url)
    
    if depth < self.max_depth:
      expr = re.compile("http(s){0,1}:\/\/([a-zA-Z0-9\-]+\.)*[a-zA-Z]+(\/([a-zA-Z0-9\-]*\.*\=*\?*)*)*")
      for match in expr.finditer(page):
        link = match.group()
        if link not in self.visited:
          self.visited.add(link)
          self.queue.put((link, depth + 1))
    
    for match in self.func(page):
      yield match

    if not self.queue.empty():
      first = self.queue.get()
      for i in self.traverse(first[0], first[1]):
        yield i
    else:
      return StopIteration()
    
if __name__ == "__main__":
  def f (page):
    expr = re.compile("[\w ]*Python(\w*,* *)*\.")
    iter = expr.finditer(page)
    return [match.group() for match in iter]

  tr = Traversal(3, f)
  iter = tr.traverse("http://rflorczak.eu/python/index.html")
  for i in iter:
    print(i)
    
  print('----')
  
  tr2 = Traversal(2, f)
  iter2 = tr2.traverse("http://rflorczak.eu/python/1.html")
  for i in iter2:
    print(i)
  