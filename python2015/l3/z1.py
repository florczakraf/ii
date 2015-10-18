from functools import *
import timeit, sys
from math import sqrt

def pierwsze_funkcyjna(n):
  primes_set = reduce((lambda r, x: r - set(range(2 * x, n + 1, x)) if (x in r) else r), range(2, n + 1), set(range(2, n + 1)))
  return sorted(list(primes_set))

def pierwsze_skladana(n):
  not_primes = [i for j in range(2, int(sqrt(n)) + 1) for i in range(j * 2, n + 1, j)]
  return [e for e in range(2, n + 1) if e not in not_primes]

if __name__ == "__main__":
  n = int(sys.argv[1]) if len(sys.argv) > 1 else 5000

  print("Primes lists:\t", timeit.timeit("pierwsze_skladana(%i)" % n, number = 1, globals = globals()))
  print("Primes funct:\t", timeit.timeit("pierwsze_funkcyjna(%i)" % n, number = 1, globals = globals()))
