extern "C"
{
  __declspec(dllexport) int _stdcall ExecuteC(int n, int (*f) (int))
  {
    return f(n);
  }
}