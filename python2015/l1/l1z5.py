def tabliczka(x1, x2, y1, y2):
  for i in range(x1, x2 + 1): print(' ', i, end = '')
  print()
  for i in range(y1, y2 + 1):
    print(i, end = '')
    for j in range(x1, x2 + 1): 
      print('', i * j, end = '')
    print()

tabliczka(3, 5, 2, 4)
