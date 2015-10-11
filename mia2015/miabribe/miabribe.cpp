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

  return 0
}

void solve(int n)
{
  int p, q;
  cin >> p >> q;
  int cells[102];
  cells[0] = 0;
  for (int i = 1; i <= q; i++)
    cin >> cells[i];
  cells[q + 1] = p + 1;
  q += 2;

  int arr[200][200];
  for (int i = 0; i < q - 1; i++)
    arr[i][i+1] = 0;

  for (int i = 2; i < q; i++)
  {
    for (int l = 0; i + l < q; l++)
    {
      int r = l + i;
      int sol = 99999999;

      for (int j = l + 1; j < r; j++)
        sol = min(sol, arr[l][j] + arr[j][r] + cells[r] - cells[l] - 2);

      arr[l][r] = sol;
    }
  }

  cout << "Case #" << n << ": " << arr[0][q - 1] << '\n';
}
