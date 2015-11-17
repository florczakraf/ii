#include<iostream>
#include<algorithm>

using namespace std;

static const int N = 1000000;
int a[N], sum, sum2, h, t, n, sol;
pair<int, int> q[2 * N];

int main()
{
  ios::sync_with_stdio(false);
  cin.tie(NULL);

  while (true)
  {
    cin >> n;
    if (n == 0)
      return 0;
    
    sum2 = sol = sum = h = t = 0;
    
    for (int i = 0; i < n; i++)
      cin >> a[i];

    for (int i = 1; i <= n; i++)
    {
      sum += a[i - 1];
      while (h < t && q[t - 1].first >= sum)
        t--;
      q[t++] = make_pair(sum, i);
    }

    for (int i = 0; i < n; i++)
    {
      while (q[h].second <= i)
        h++;

      if (q[h].first - sum2 >= 0)
        sol++;

      sum += a[i];
      sum2 += a[i];

      while (h < t && q[t - 1].first >= sum)
        t--;

      q[t++] = make_pair(sum, i + n + 1);
    }

    cout << sol << '\n';
    
  }

  return 0;
}

