#include<iostream>
#include<algorithm>

using namespace std;

void solve(int n);

int main()
{
  ios::sync_with_stdio(false);
  cin.tie(NULL);

  int n;
  cin >> n;

  for (int i = 1; i <= n; i++)
    solve(i);
}

void solve(int n)
{
  int p, q, bribe = 0, current, * order, min_bribe = 0;
  cin >> p >> q;
  order = new int[q];

  for (int i = 0; i < q; i++)
    cin >> order[i];

  do
  {
    bool cells[p] = {true};
    for (int i = 0; i < q; i++)
    {
      int current = order[i] - 1;
      cells[current] = 0;
      for (int j = current - 1; j > 0 && cells[j] != 0; j--)
        bribe++;
      for (int j = current + 1; j < n && cells[j] != 0; j++)
        bribe++;
    }
    min_bribe = (min_bribe < bribe) ? min_bribe : bribe;
  }
  while (next_permutation(order, order + q))

  cout << "Case #" << n << ": " << min_bribe;
}
