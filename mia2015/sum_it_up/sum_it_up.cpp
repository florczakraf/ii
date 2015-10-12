#include<iostream>
#include<algorithm>

using namespace std;

int main()
{
  ios::sync_with_stdio(false);
  cin.tie(NULL);

  static const int MODULO = 1000000007;
  int n, q, tmp;
  long sum = 0;
  cin >> n;
  for (int i = 0; i < n; i++)
  {
    cin >> tmp;
    sum = (sum + tmp) % MODULO;
  }

  cin >> q;

  for (int i = 0; i < q; i++)
  {
    sum = (sum * 2) % MODULO;
  }

  cout << sum;
  return 0;
}

