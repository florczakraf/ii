Problem ucztujących filozofów
============

Opis
----
*N* filozofów siedzi wokół okrągłego stołu. Między każdą parą sąsiadów znajduje się widelec.
Do zjedzenia posiłku potrzebne są dwa widelce. Gdy każdy filozof weźmie widelec po swojej prawej
stronie dojdzie do zakleszczenia, ponieważ *1* będzie czekał aż *N* zwolni swój widelec, *2* będzie
czekał na *1* i tak dalej.

Rozwiązanie
-----
Rozwiązanie oparłem na bazie pomysłu Tannenbauma opisanego tutaj: https://www.cs.indiana.edu/classes/p415-sjoh/hw/project/dining-philosophers/index.htm

W dużym skrócie: Stworzyłem *N + 1* semaforów: po jednym dla każdego widelca oraz jeden do nadzorowania wzajemnego 
wykluczenia dostępu do sekcji krytycznej. Każdy filozof znajduje się w jednym z 3 stanów: *jedzenia*, *rozmyślania* albo 
*bycia głodnym*. Aby filozof *i* mógł przejść ze stanu *bycia głodym* do *jedzenia*, jego sąsiedzi nie mogą się znajdować
w stanie *jedzenia*.
