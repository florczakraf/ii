import timeit, sys

def doskonale_skladana(n):
  def divs(m):
    return [i for i in range(1, int(m / 2) + 1) if m % i == 0]
  return [i for i in range(2, n) if sum(divs(i)) == i]

def doskonale_funkcyjna(n):
  divs = lambda m: list(filter(lambda e: m % e == 0, range(1, int(m / 2) + 1)))
  return list(filter(lambda e: (e == sum(divs(e))), range(2, n)))

if __name__ == "__main__":
  n = int(sys.argv[1]) if len(sys.argv) > 1 else 10000

  print("Perfects lists:\t", timeit.timeit("doskonale_skladana(%i)" % n, number = 1, setup = "from __main__ import doskonale_skladana"))
  print("Perfects funct:\t", timeit.timeit("doskonale_funkcyjna(%i)" % n, number = 1, setup = "from __main__ import doskonale_funkcyjna"))
