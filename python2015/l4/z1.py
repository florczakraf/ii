import timeit, sys

def doskonale_skladana(n):
  def divs(m):
    return [i for i in range(1, int(m / 2) + 1) if m % i == 0]
  return [i for i in range(2, n) if sum(divs(i)) == i]

def doskonale_funkcyjna(n):
  divs = lambda m: list(filter(lambda e: m % e == 0, range(1, int(m / 2) + 1)))
  return list(filter(lambda e: (e == sum(divs(e))), range(2, n)))
  
def doskonale_iteracyjna(n):
  divs = lambda m: list(filter(lambda e: m % e == 0, range(1, int(m / 2) + 1)))
  return filter(lambda e: (e == sum(divs(e))), range(2, n))

def it(n):
  for i in doskonale_iteracyjna(n):
    pass

def it_fun(n):
  for i in doskonale_funkcyjna(n):
    pass

if __name__ == "__main__":
  
  ns = [10, 100, 1000, 10000]
  tests = ["doskonale_skladana", "it_fun", "it"]
  
  for t in tests:
    print("%s:" % t)
    for n in ns:
      print("%d: %.8f" % (n, timeit.timeit("%s(%i)" % (t, n), number = 1, setup = "from __main__ import %s" % t)), "\t", end = "")
    print()
