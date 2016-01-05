#include<iostream>
#include<algorithm>
#include<string>
#include<map>

using namespace std;

char keypad(char key)
{
  if (key <= 'c')
    return '2';
  else if (key <= 'f')
    return '3';
  else if (key <= 'i')
    return '4';
  else if (key <= 'l')
    return '5';
  else if (key <= 'o')
    return '6';
  else if (key <= 's')
    return '7';
  else if (key <= 'v')
    return '8';
  else
    return '9';
}

int main()
{
  ios::sync_with_stdio(false);
  cin.tie(NULL);

  int n;
  string tmp;
  cin >> n;

  map<string, int> dict;

  for (int i = 0; i < n; i++)
  {
    cin >> tmp;
    transform(tmp.begin(), tmp.end(), tmp.begin(), keypad);
    dict[tmp] += 1;
  }
  cin >> tmp;
  cout << dict[tmp];
  return 0;
}