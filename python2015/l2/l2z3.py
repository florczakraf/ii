import timeit

class FactSolution(Exception):
  def __init__(self, value):
    self.value = value

  def __str__(self):
    return str(self.value)

class FibSolution(Exception):
  def __init__(self, value):
    self.value = value

  def __str__(self):
    return str(self.value)

def fact(n):
  if n <= 1: return 1
  else: return n * fact(n - 1)

def fact_exc(n):
  def fact_helper(a, n):
    if n <= 1: raise FactSolution(a)
    else: return fact_helper(a *n, n - 1)
  return fact_helper(1, n)

def fib(n):
  if n <= 2: return 1
  else: return fib(n - 1) + fib(n - 2)

def fib_exc(n):
  def fib_helper(a, b, n):
    if n > 0:
      return fib_helper(b, a + b, n - 1)
    else: raise FibSolution(a)
  return fib_helper(0, 1, n)

def main():
  t_fact = "fact(500)"
  t_fact_exc = """\
try:
  fact_exc(500)
except FactSolution as solution:
  solution.value
"""

  t_fib = "fib(30)"
  t_fib_exc = """\
try:
  fib_exc(30)
except FibSolution as solution:
  solution.value
"""

  print("recursive fact:", timeit.timeit(stmt = t_fact, number = 1, setup = "from __main__ import FactSolution, fact, fact_exc"))
  print("exception fact:", timeit.timeit(stmt = t_fact_exc, number = 1, setup = "from __main__ import FactSolution, fact, fact_exc"))

  print("recursive fib:", timeit.timeit(stmt = t_fib, number = 1, setup = "from __main__ import FibSolution, fib, fib_exc"))
  print("exception fib:", timeit.timeit(stmt = t_fib_exc, number = 1, setup = "from __main__ import FibSolution, fib, fib_exc"))

if __name__ == '__main__':
  main()
