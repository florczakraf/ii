/*
* Problemy:
* "Zadanie 1.1.1" ->  TEXT("Zadanie 1.1.1")
*/
#include <windows.h>
#include <stdlib.h>
/* Deklaracja wyprzedzająca: funkcja obsługi okna */
LRESULT CALLBACK WindowProcedure(HWND, UINT, WPARAM, LPARAM);
/* Nazwa klasy okna */
char szClassName[] = "KlasaOkna";

static const int STEP = 4;

inline int f1(int x)
{
  return abs(x);
}

inline int f2(int x)
{
  return x * x / 10;
}

int xs, ys;

int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nShowCmd)
{
  HWND hwnd;               /* Uchwyt okna */
  MSG messages;            /* Komunikaty okna */
  WNDCLASSEX wincl;        /* Struktura klasy okna */

                           /* Klasa okna */
  wincl.hInstance = hInstance;
  wincl.lpszClassName = szClassName;
  wincl.lpfnWndProc = WindowProcedure;    // wskaźnik na funkcję 
                                          // obsługi okna  
  wincl.style = CS_DBLCLKS;
  wincl.cbSize = sizeof(WNDCLASSEX);

  /* Domyślna ikona i wskaźnik myszy */
  wincl.hIcon = LoadIcon(NULL, IDI_APPLICATION);
  wincl.hIconSm = LoadIcon(NULL, IDI_APPLICATION);
  wincl.hCursor = LoadCursor(NULL, IDC_ARROW);
  wincl.lpszMenuName = NULL;
  wincl.cbClsExtra = 0;
  wincl.cbWndExtra = 0;
  wincl.hbrBackground = (HBRUSH)GetStockObject(WHITE_BRUSH);

  /* Rejestruj klasę okna */
  if (!RegisterClassEx(&wincl)) return 0;

  /* Twórz okno */
  hwnd = CreateWindowEx(
    0, szClassName,
    TEXT("Zadanie 1.1.1"),
    WS_OVERLAPPEDWINDOW,
    CW_USEDEFAULT, CW_USEDEFAULT,
    512, 512,
    HWND_DESKTOP, NULL,
    hInstance, NULL);

  ShowWindow(hwnd, nShowCmd);
  UpdateWindow(hwnd);
  /* Pętla obsługi komunikatów */
  while (GetMessage(&messages, NULL, 0, 0))
  {
    /* Tłumacz kody rozszerzone */
    TranslateMessage(&messages);
    /* Obsłuż komunikat */
    DispatchMessage(&messages);
  }

  /* Zwróć parametr podany w PostQuitMessage( ) */
  return messages.wParam;
}

/* Tę funkcję woła DispatchMessage( ) */
LRESULT CALLBACK WindowProcedure(HWND hwnd, UINT message,
  WPARAM wParam, LPARAM lParam)
{

  RECT rect;
  HDC hdc;

  PAINTSTRUCT ps;

  int xhalf, yhalf;

  HPEN pen_f1, pen_f2, pen_axes;

  switch (message)
  {
    case WM_DESTROY:
      PostQuitMessage(0);
      break;
    case WM_SIZE:
      xs = LOWORD(lParam);
      ys = HIWORD(lParam);
      
      GetClientRect(hwnd, &rect);
      InvalidateRect(hwnd, &rect, 1);

      break;
    case WM_PAINT:
      xhalf = xs / 2;
      yhalf = ys / 2;

      pen_f1 = CreatePen(PS_DOT, 1, RGB(240, 55, 64));
      pen_f2 = CreatePen(PS_DASHDOTDOT, 1, RGB(76, 200, 167));
      pen_axes = CreatePen(PS_SOLID, 2, RGB(0, 0, 0));

      hdc = BeginPaint(hwnd, &ps);
      // draw axes
      SelectObject(hdc, pen_axes);
      MoveToEx(hdc, xhalf, 0, 0);
      LineTo(hdc, xhalf, ys);
      MoveToEx(hdc, 0, yhalf, 0);
      LineTo(hdc, xs, yhalf);

      // draw f1
      SelectObject(hdc, pen_f1);
      MoveToEx(hdc, xhalf, yhalf - f1(0), 0);
      for (int x = xhalf - STEP; x > 0; x -= STEP) // x <= 0
      {
        int y = yhalf - f1(x - xhalf);
        LineTo(hdc, x, y);
        MoveToEx(hdc, x, y, 0);
      }
      MoveToEx(hdc, xhalf, yhalf - f1(0), 0);
      for (int x = xhalf + STEP; x < xs; x += STEP) // x >= 0
      {
        int y = yhalf - f1(x - xhalf);
        LineTo(hdc, x, y);
        MoveToEx(hdc, x, y, 0);
      }

      // draw f2
      SelectObject(hdc, pen_f2);
      MoveToEx(hdc, xhalf, yhalf - f2(0), 0);
      for (int x = xhalf - STEP; x > 0; x -= STEP) // x <= 0
      {
        int y = yhalf - f2(x - xhalf);
        LineTo(hdc, x, y);
        MoveToEx(hdc, x, y, 0);
      }
      MoveToEx(hdc, xhalf, yhalf - f2(0), 0);
      for (int x = xhalf + STEP; x < xs; x += STEP) // x >= 0
      {
        int y = yhalf - f2(x - xhalf);
        LineTo(hdc, x, y);
        MoveToEx(hdc, x, y, 0);
      }

      DeleteObject(pen_f1);
      DeleteObject(pen_f2);
      DeleteObject(pen_axes);
      EndPaint(hwnd, &ps);

      break;
  default:
    return DefWindowProc(hwnd, message, wParam, lParam);
  }
  return 0;
}