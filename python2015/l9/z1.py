"""http://pep8online.com/s/LvKEHgnw"""
from io import StringIO
import unittest
import types

class EmptyString(Exception):
    pass

class L4Z3:
  def upper_first(strng):
    """Changes first letter of a string to capital; throws EmptyString when argument
    is empty string; asserts argument is a string"""
    assert isinstance(strng, str)
    if (len(strng) == 0):
      raise EmptyString
    return strng[0].upper() + strng[1:]

  def korekta(strng):
    """Processes given string so it starts with capital letter and ends with dot followed by space;
    throws EmptyString when argument is empty string; asserts argument is a string"""
    assert isinstance(strng, str)
    if (len(strng) == 0):
      raise EmptyString
    strng = L4Z3.upper_first(strng)
    if strng[-2:] == '. ':
      return strng
    elif strng[-1] == '.':
      return strng + ' '
    else:
      return strng + '. '

  def zdania(stream):
    """Iterator that splits given stream into sentences"""
    sentences = stream.read().split(sep = '.')
    sentences = filter(None, map(lambda s: s.replace("\n", " ").strip(), sentences))

    for s in sentences:
      yield "%s." % s


class Tests(unittest.TestCase):
  def test_upper_first(self):
    self.assertEqual(L4Z3.upper_first("Lorem ipsum"), "Lorem ipsum")
    self.assertEqual(L4Z3.upper_first("lorem ipsum"), "Lorem ipsum")
    self.assertEqual(L4Z3.upper_first("l"), "L")
    self.assertRaises(AssertionError, L4Z3.upper_first, 5)
    self.assertRaises(EmptyString, L4Z3.upper_first, "")

  def test_korekta(self):
    self.assertEqual(L4Z3.korekta("to jest testowy string"), "To jest testowy string. ")
    self.assertEqual(L4Z3.korekta("to jest testowy string."), "To jest testowy string. ")
    self.assertEqual(L4Z3.korekta("to jest testowy string. "), "To jest testowy string. ")
    self.assertEqual(L4Z3.korekta("To jest testowy string."), "To jest testowy string. ")
    self.assertEqual(L4Z3.korekta("To jest testowy string. "), "To jest testowy string. ")
    self.assertRaises(EmptyString, L4Z3.korekta, "")
    self.assertRaises(AssertionError, L4Z3.korekta, 23)

  def test_zdania(self):
    str = StringIO("to jest testowy string. Iterator powinien zwr.acać z niego pojedyncze zdania.\ncokolwiek to znaczy.")
    it = L4Z3.zdania(StringIO("to jest testowy string. Iterator powinien zwr.acać z niego pojedyncze zdania.\ncokolwiek to znaczy."))

    self.assertEqual(list(L4Z3.zdania(str)), ['to jest testowy string.', 'Iterator powinien zwr.', 'acać z niego pojedyncze zdania.',
                                              'cokolwiek to znaczy.'])
    self.assertEqual(next(it), "to jest testowy string.")

if __name__ == "__main__":
  unittest.main()

