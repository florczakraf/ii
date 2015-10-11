import timeit

class FactSolution(Exception):
  def __init__(self, value):
    self.value = value
  
  def __str__(self):
    return str(self.value)

def fact(n):
  if n <= 1: return 1
  else: return n * fact(n - 1)

def fact_exc(n, sol):
  if n <= 1: raise FactSolution(sol)
  else: return fact_exc(n - 1, sol * n)
  
def main():
  t_fact = "fact(500)"
  t_fact_exc = """\
try:
  fact_exc(500, 1)
except FactSolution as solution:
  solution.value
"""
                    
  print("recursive:", timeit.timeit(stmt = t_fact, number = 100, setup = "from __main__ import FactSolution, fact, fact_exc"))
  print("exception:", timeit.timeit(stmt = t_fact_exc, number = 100, setup = "from __main__ import FactSolution, fact, fact_exc"))

if __name__ == '__main__':
  main()