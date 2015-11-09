from io import StringIO

def upper_first(str):
  return str[0].upper() + str[1:]
  
def korekta(str):
  str = upper_first(str)
  if str[-2:] == '. ':
    return str
  elif str[-1] == '.':
    return str + ' '
  else:
    return str + '. '

def zdania(stream):
  sentences = stream.read().split(sep = '.')
  sentences = filter(None, map(lambda s: s.replace("\n", " ").strip(), sentences))
  
  for s in sentences:
    yield "%s." % s

if __name__ == "__main__":
  str = "to jest testowy string. Iterator powinien zwr.acać z niego pojedyncze zdania.\ncokolwiek to znaczy."
  in1 = StringIO(str)
  in2 = StringIO(str)
  before = list(zdania(in1))
  after = list(map(lambda s: korekta(s), zdania(in2)))
  print("Przed: ", before)
  print("Po: ", after)
  in1.close()
  in2.close()
