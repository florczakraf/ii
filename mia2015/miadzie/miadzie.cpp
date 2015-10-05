#include<iostream>

using namespace std;

int main()
{
  ios::sync_with_stdio(false);
  cin.tie(NULL);

  int n, sol = 0;
  cin >> n;
  int tab[n];

  for (int i = 0; i < n; i++)
    cin >> tab[i];

  for (int i = 0; i < n; i++)
  {
    if (tab[i] > 0)
    {
      sol++;
      int j = tab[i] - 1;
      tab[i] = 0;

      while (tab[j] != 0)
      {
        int next = tab[j] - 1;
        tab[j] = 0;
        j = next;
      }
    }
  }

  cout << sol - 1;
  return 0;
}

