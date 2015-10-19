#include<iostream>
#include<algorithm>

using namespace std;

void solve();

int tab[10][10];

int main()
{
  ios::sync_with_stdio(false);
  cin.tie(NULL);

  int n;
  cin >> n;

  for (int i = 1; i <= n; i++)
    solve();

  return 0;
}

void solve()
{
  int n;
  cin >> n;
  for (int i = 0; i < n; i++)
    for (int j = 0; j < n; j++)
      cin >> tab[i][j];
  
  int diff[11];

  for (int i = 1; i < n; i++)
    diff[i] = tab[0][i] - tab[0][i - 1];

  for (int i = 1; i < n; i++)
  {
    for (int j = 1; j < n; j++)
    {
      if (tab[i][j] - tab[i][j - 1] != diff[j])
      {
        cout << "NIE\n"; 
        return;
      }
    }
  }

  for (int i = 1; i < n; i++)
    diff[i] = tab[i][0] - tab[i - 1][0];

  for (int i = 1; i < n; i++)
  {
    for (int j = 1; j < n; j++)
    {
      if (tab[j][i] - tab[j - 1][i] != diff[j])
      {
        cout << "NIE\n"; 
        return;
      }
    }
  }

  
  cout << "TAK\n";
}
