#include<iostream>

using namespace std;

int main()
{
  ios::sync_with_stdio(false);
  cin.tie(NULL);

  int n;
  char tmp;
  cin >> n;

  for (int i = 1; i <= n; i++)
  {
    int c = 0;
    for (int j = 0; j < n; j++)
    {
      cin >> tmp;
      if (tmp == '1')
        c++;
    }
    if (c == 1)
    {
      cout << 1 << '\n' << i;
      return 0;
    }
  }

  return 0;
}

