#include<iostream>

using namespace std;

static const int LIM = 500001;

int steps[LIM];

int binsrch(int v, int l, int r)
{
  if (l == r)
    return steps[l] <= v ? l : -1;

  int mid = (l + r) / 2;

  if (v < steps[mid])
    return binsrch(v, l, mid);
  else
  {
    int candidate = binsrch(v, mid + 1, r);
    return candidate == -1 ? mid : candidate;
  }  
}

int main()
{
  ios::sync_with_stdio(false);
  cin.tie(NULL);

  int n, m, tmp;
  cin >> n >> m;
  
  steps[0] = -1;
  for (int i = 1; i <= n; i++)
  {
    cin >> tmp;
    steps[i] = max(steps[i - 1], tmp);
  }

  for (int i = 0; i < m; i++)
  {
    cin >> tmp;
    cout << binsrch(tmp - 1, 0, n) << ' ';
  }

  return 0;
}

