#include<iostream>
#include<vector>
#include<queue>
#include<climits>

using namespace std;

static const int NNODES = 10001;
int d[NNODES];

struct edge
{
  int w;
  int n;

  edge() {}
  edge(int n, int w) : n(n), w(w) {}
  bool operator < (const edge &other) const
  {
    return w > other.w;
  }
};

int dijkstra(vector< vector<edge> > &graph, int n, int s, int t)
{
  for (int i = 0; i < n; i++)
    d[i] = INT_MAX;

  d[s] = 0;
  priority_queue<edge> q;
  q.push(edge(s, 0));

  while (!q.empty())
  {
    int node = q.top().n;
    int dist = q.top().w;
    q.pop();

    if (dist > d[node])
      continue;

    if (node == t)
      return dist;

    for (int i = 0; i < graph[node].size(); i++)
    {
      int next = graph[node][i].n;
      int weight = graph[node][i].w;

      if (dist + weight < d[next])
      {
        d[next] = dist + weight;
        q.push(edge(next, d[next]));
      }
    }
  }
  return INT_MAX;
}

int main()
{
  ios::sync_with_stdio(false);
  cin.tie(NULL);

  int n, m;
  cin >> n >> m;

  vector<vector <edge> > g(n);
  vector<int> p1(m), p2(m), w(m);

  for (int i = 0; i < m; i++)
  {
    cin >> p1[i] >> p2[i] >> w[i];;
    g[p1[i]].push_back(edge(p2[i], w[i]));
    g[p2[i]].push_back(edge(p1[i], w[i]));
  }

  int shortest = dijkstra(g, n, 0, n - 1);
  vector<int> dist(n);

  for (int i = 0; i < n; i++)
    dist[i] = d[i];

  dijkstra(g, n, n - 1, 0);

  long long sol = 0;

  for (int i = 0; i < m; i++)
  {
    int u = p1[i];
    int v = p2[i];
    int weight = w[i];

    if ((dist[u] + weight + d[v] == shortest) || dist[v] + weight + d[u] == shortest)
      sol += weight * 2;
  }

  cout << sol;
  return 0;
}
