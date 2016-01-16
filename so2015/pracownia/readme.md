Problem ucztujących filozofów
============

Opis
----
*N* filozofów siedzi wokół okrągłego stołu. Między każdą parą sąsiadów znajduje się widelec.
Do zjedzenia posiłku potrzebne są dwa widelce. Gdy każdy filozof weźmie widelec po swojej prawej
stronie dojdzie do zakleszczenia, ponieważ pierwszy będzie czekał aż N-ty zwolni swój widelec, drugi będzie
czekał na pierwszego i tak dalej.

Rozwiązanie
-----
Rozwiązanie oparłem na bazie pomysłu Tannenbauma opisanego tutaj:
https://www.cs.indiana.edu/classes/p415-sjoh/hw/project/dining-philosophers/index.htm

W skrócie: stworzyłem *N + 1* semaforów: po jednym dla każdego widelca oraz jeden do nadzorowania wzajemnego 
wykluczenia dostępu do sekcji krytycznej. Każdy filozof znajduje się w jednym z 3 stanów: *jedzenia*, *rozmyślania* albo 
*bycia głodnym*. Stanem początkowym każdego filozofa jest *rozmyślanie*. Po jakimś czasie filozof dochodzi do wniosku, 
że coś by zjadł, więc przechodzi w stan *bycia głodnym*. Aby filozof *i* mógł przejść ze stanu *bycia głodym* do *jedzenia*, 
jego sąsiedzi nie mogą się znajdować w stanie *jedzenia*. Gdy jakiś filozof kończy jedzenie, to odkłada oba widelce 
i informuje o tym fakcie swoich sąsiadów, a następnie wraca do *rozmyślania*.

Sposób użycia
-----
Aby skompilować program w wersji, która nie wypisuje zmian stanów poszczególnych filozofów należy użyć polecenia
`make`. Po skompilowaniu program można uruchomić przy użyciu `./philosophers`

Inną możliwością jest użycie polecenia `make debug`, a następnie `./debug`. W tej wersji program wypisuje zmiany stanów 
filozofów.

Testowanie
-------
W ramach testów ustaliłem docelową minimalną liczbę posiłków spożytych przez każdego filozofa potrzebną do zakończenia
działania programu (`TARGET`). W załączonej wersji programu jest 5 filozofów, a `TARGET` wynosi 50. Niezależnie od
tego którą z metod opisanych w poprzednim punkcie użyjemy, na końcu działania programu wyświetli się zestawienie
zawierające liczbę spożytych posiłków przez każdego z filozofów (patrz punkt następny).

Przykładowe wyniki działania programu:
--------
```
rf@rflaptop:~/ii/so2015/pracownia$ ./philosophers 
Starting process with pid 14765
Starting process with pid 14766
Starting process with pid 14767
Starting process with pid 14768
Starting process with pid 14769
-----RESULTS-----
N = 5
TARGET = 50
Philosopher #1 ate 54 times
Philosopher #2 ate 52 times
Philosopher #3 ate 50 times
Philosopher #4 ate 50 times
Philosopher #5 ate 51 times
```
```
rf@rflaptop:~/ii/so2015/pracownia$ ./debug 
Starting process with pid 12550
Starting process with pid 12551
Starting process with pid 12552
Starting process with pid 12553
Starting process with pid 12554
Philosopher #1 is hungry
Philosopher #1 takes spoons: 4 and 1
Philosopher #1 eats
Philosopher #2 is hungry
Philosopher #3 is hungry

(...)

Philosopher #1 takes spoons: 5 and 1
Philosopher #1 eats
Philosopher #1 puts down spoons: 5 and 1
Philosopher #1 thinks
-----RESULTS-----
N = 5
TARGET = 50
Philosopher #1 ate 58 times
Philosopher #2 ate 51 times
Philosopher #3 ate 50 times
Philosopher #4 ate 50 times
Philosopher #5 ate 57 times
```
