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
Rozwiązanie oparłem na bazie pomysłu Tannenbauma opisanego tutaj:
https://www.cs.indiana.edu/classes/p415-sjoh/hw/project/dining-philosophers/index.htm

W skrócie: stworzyłem *N + 1* semaforów: po jednym dla każdego widelca oraz jeden do nadzorowania wzajemnego 
wykluczenia dostępu do sekcji krytycznej. Każdy filozof znajduje się w jednym z 3 stanów: *jedzenia*, *rozmyślania* albo 
*bycia głodnym*. Stanem początkowym każdego filozofa jest *rozmyślanie*. Po jakimś czasie dochodzi do wniosku, że coś by
zjadł, więc przechodzi w stan *bycia głodnym*. Aby filozof *i* mógł przejść ze stanu *bycia głodym* do *jedzenia*, 
jego sąsiedzi nie mogą się znajdować w stanie *jedzenia*. Gdy jakiś filozof kończy jedzenie, to odkłada oba widelce 
i informuje o tym fakcie swoich sąsiadów i wraca do *rozmyślania*.

Sposób użycia
-----
Aby skompilować program w wersji, która nie wypisuje zmian stanów poszczególnych filozofów należy użyć polecenia
`make`. Po skompilowaniu program można uruchomić przy użyciu `./philosophers`

Inną możliwością jest użycie polecenia `make debug`, a następnie `./debug`. W tej wersji program wypisuje zmiany stanów 
filozofów, a także wprowadza opóźnienia między kolejnymi funkcjami.

Testowanie
-------
W ramach testów ustaliłem docelową minimalną liczbę posiłków spożytych przez każdego filozofa potrzebną do zakończenia
działania programu (`TARGET`). W załączonej wersji programu jest 4 filozofów, a `TARGET` wynosi 10. Niezależnie od
tego którą z metod opisanych w poprzednim punkcie użyjemy, na końcu działania programu wyświetli się zestawienie
zawierające liczbę spożytych posiłków przez każdego z filozofów (patrz punkt następny).

Przykładowe wyniki działania programu:
--------
```
rf@rflaptop:~/ii/so2015/pracownia$ ./philosophers 
Starting process with pid 12528
Starting process with pid 12529
Starting process with pid 12530
Starting process with pid 12531
-----RESULTS-----
N = 4
TARGET = 10
Philosopher #1 ate 69 times
Philosopher #2 ate 21 times
Philosopher #3 ate 10 times
Philosopher #4 ate 2834 times
```
```
rf@rflaptop:~/ii/so2015/pracownia$ ./debug 
Starting process with pid 12550
Starting process with pid 12551
Starting process with pid 12552
Starting process with pid 12553
Philosopher #1 is hungry
Philosopher #1 takes spoon 4 and 1
Philosopher #1 eats
Philosopher #2 is hungry
Philosopher #3 is hungry

(...)

-----RESULTS-----
N = 4
TARGET = 10
Philosopher #1 ate 10 times
Philosopher #2 ate 10 times
Philosopher #3 ate 10 times
Philosopher #4 ate 11 times
```

