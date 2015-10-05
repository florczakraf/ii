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

  return 0;
}

