import random, sys

def rzut_kostka():
  return random.randint(1, 6)

def main(argv):
  n = int(argv[0])
  wins = [0, 0]
  print("|roll1\t|roll2\t||wins1\t|wins2\t|")

  for i in range(n):
    wins = round(wins)
  
  if wins[0] == wins[1]:
    print("overtime:")
    draw = True
    while draw:
      wins = round(wins)
      draw = wins[0] == wins[1]
      
def roll():
  rolls = [0, 0]
  rolls[0] = rzut_kostka() + rzut_kostka()
  rolls[1] = rzut_kostka() + rzut_kostka()
  return rolls

def round(wins):
  rolls = roll()
  if rolls[0] > rolls[1]: wins[0] += 1
  elif rolls[1] > rolls[0]: wins[1] += 1
  print("|", rolls[0], "\t|", rolls[1], "\t||", wins[0], "\t|", wins[1], "\t|")
  return wins
  

if __name__ == "__main__":
  main(sys.argv[1:])
