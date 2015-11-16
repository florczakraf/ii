from urllib.request import urlopen
import re
import queue
import threading

class Traversal:
  def __init__(self, max_depth, func, url):
    self.func = func
    self.max_depth = max_depth
    self.visited = set()
    self.visited_lock = threading.Condition()
    self.solution = queue.Queue()
    self.visited.add(url)
    self.threads = queue.Queue()
    self.finished = queue.Queue()
    thrd = threading.Thread(target = self.traverse, args=(url, 1))
    thrd.start()
    self.threads.put(thrd.ident)

  def iter(self):
    while True:
      try:
        yield self.solution.get(False)
      except queue.Empty:
        if self.threads.qsize() == self.finished.qsize() and self.solution.empty():
          raise StopIteration()

  def traverse(self, url, depth):
    try:
      page = urlopen(url).read().decode('utf-8')
    except:
      print("There was an error while processing: %s" % url)
      self.finished.put(threading.get_ident())
      return

    if depth < self.max_depth:
      expr = re.compile("http(s){0,1}:\/\/([a-zA-Z0-9\-]+\.)*[a-zA-Z]+(\/([a-zA-Z0-9\-]*\.*\=*\?*)*)*")
      for match in expr.finditer(page):
        link = match.group()
        self.visited_lock.acquire()
        if link not in self.visited:
          self.visited.add(link)
          thrd = threading.Thread(target = self.traverse, args = (link, depth + 1))
          thrd.start()
          self.threads.put(thrd)
        self.visited_lock.notify()
        self.visited_lock.release()

    for match in self.func(page):
      self.solution.put(match)

    self.finished.put(threading.get_ident())


if __name__ == "__main__":
  def f (page):
    expr = re.compile("[\w ]*Python(\w*,* *)*\.")
    iter = expr.finditer(page)
    return [match.group() for match in iter]

  tr = Traversal(3, f, "http://rflorczak.eu/python/index.html")
  iter = tr.iter()
  for i in iter:
    print(i)

  print('----')

  tr2 = Traversal(2, f, "http://rflorczak.eu/python/1.html")
  iter2 = tr2.iter()
  for i in iter2:
    print(i)

  print('----')

  tr3 = Traversal(5, f, "http://rflorczak.eu/python/error.html")
  iter3 = tr3.iter()
  for i in iter3:
    print(i)


