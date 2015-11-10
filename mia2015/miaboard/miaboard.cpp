#include<iostream>
#include<vector>

using namespace std;

int count_swaps(vector<int> v)
{
  int ret = 0;
  for (int i = 0; i < v.size(); i++)
    if (v[i] % 2 == 0)
      ret += 1;
  return ret;
}

string inv(string v)
{
  for (int i = 0; i < v.length(); i++)
    v[i] = v[i] == '0' ? '1' : '0';
  return v;
}

int min_swaps(int n, vector <string> M)
{
  string A = M[0];
  string B = inv(M[0]);
  vector<int> vA, vB;

  for (int i = 0; i < n; i++)
  {
    if (M[i] == A)
      vA.push_back(i);
    else if (M[i] == B)
      vB.push_back(i);
    else
      return -1;
  }
  
  if (vA.size() != vB.size())
    return -1;

  return min(count_swaps(vA), count_swaps(vB));   
}

void solve(int n, vector <string> M)
{
  int swaps = min_swaps(n, M);
  if (swaps == -1)
  {
    cout << "IMPOSSIBLE";
    return;
  }

  vector <string> transposed(n);
  
  for (int i = 0; i < n; i++)
  {
    transposed[i].resize(n);
    for (int j = 0; j < n; j++)
      transposed[i][j] = M[j][i];
  }
  
  int swaps2 = min_swaps(n, transposed);
  if (swaps2 == -1)  
  {
    cout << "IMPOSSIBLE";
    return;
  }
  cout << swaps + swaps2;
}

int main()
{
  ios::sync_with_stdio(false);
  cin.tie(NULL);

  int t, n;
  string tmp;
  cin >> t;

  for (int i = 1; i <= t; i++)
  {
    cin >> n;
    n *= 2;

    vector <string> M;

    for (int j = 0; j < n; j++)
    {
      cin >> tmp;
      M.push_back(tmp);
    }
    
    cout << "Case #" << i << ": ";
    solve(n, M);
    cout << '\n';
  }

  return 0;
}

