#include <windows.h>
#include <CommCtrl.h>
#include <stdlib.h>
#include <stdio.h>
#include <time.h>

#define ID_PROGRESSBAR 101
#define ID_STATUSBAR 102
#define ID_LISTVIEW 103


/* Deklaracja wyprzedzaj¹ca: funkcja obs³ugi okna */
LRESULT CALLBACK WindowProcedure(HWND, UINT, WPARAM, LPARAM);
/* Nazwa klasy okna */
char szClassName[] = "WsdfSDG4gsdr34f";

HWND hProgressbar, hStatusbar, hListbox;

int clicks = 0;

HINSTANCE * hMainInstance;

int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nShowCmd)
{
  srand(time(NULL));
  hMainInstance = &hInstance;

  HWND hwnd;               /* Uchwyt okna */
  MSG messages;            /* Komunikaty okna */
  WNDCLASSEX wincl;        /* Struktura klasy okna */

                           /* Klasa okna */
  wincl.hInstance = hInstance;
  wincl.lpszClassName = szClassName;
  wincl.lpfnWndProc = WindowProcedure;    // wskaŸnik na funkcjê 
                                          // obs³ugi okna  
  wincl.style = CS_DBLCLKS;
  wincl.cbSize = sizeof(WNDCLASSEX);

  /* Domyœlna ikona i wskaŸnik myszy */
  wincl.hIcon = LoadIcon(NULL, IDI_APPLICATION);
  wincl.hIconSm = LoadIcon(NULL, IDI_APPLICATION);
  wincl.hCursor = LoadCursor(NULL, IDC_ARROW);
  wincl.lpszMenuName = NULL;
  wincl.cbClsExtra = 0;
  wincl.cbWndExtra = 0;
  wincl.hbrBackground = (HBRUSH)GetStockObject(WHITE_BRUSH);

  /* Rejestruj klasê okna */
  if (!RegisterClassEx(&wincl)) return 0;

  /* Twórz okno */
  hwnd = CreateWindowEx(
    0, szClassName,
    TEXT("1.1.5"),
    WS_OVERLAPPEDWINDOW,
    CW_USEDEFAULT, CW_USEDEFAULT,
    500, 300,
    HWND_DESKTOP, NULL,
    hInstance, NULL);

  ShowWindow(hwnd, nShowCmd);
  UpdateWindow(hwnd);

  /* Pêtla obs³ugi komunikatów */
  while (GetMessage(&messages, NULL, 0, 0))
  {
    /* T³umacz kody rozszerzone */
    TranslateMessage(&messages);
    /* Obs³u¿ komunikat */
    DispatchMessage(&messages);
  }

  /* Zwróæ parametr podany w PostQuitMessage( ) */
  return messages.wParam;
}

/* Tê funkcjê wo³a DispatchMessage( ) */
LRESULT CALLBACK WindowProcedure(HWND hwnd, UINT message,
  WPARAM wParam, LPARAM lParam)
{
  PAINTSTRUCT ps;
  HDC hdc;
  int tmp;
  WCHAR buf[80];

  switch (message)
  {
  case WM_LBUTTONDOWN:
    clicks += 1;
    tmp = rand() % 101;
    swprintf_s(buf, 80, TEXT("Wartoœæ: %d"), tmp);
    SendMessage(hProgressbar, PBM_SETPOS, tmp, NULL);
    SendMessage(hListbox, LB_INSERTSTRING, 0, (LPARAM)buf);
    swprintf_s(buf, 80, TEXT("Klikniêæ: %d"), clicks);
    SendMessage(hStatusbar, SB_SETTEXT, 0, (LPARAM)buf);
    break;
  case WM_DESTROY:
    PostQuitMessage(0);
    break;
  case WM_SIZE:
    SendMessage(hStatusbar, WM_SIZE, 0, 0);
    break;
  case WM_CREATE:
    hProgressbar = CreateWindowEx(0, PROGRESS_CLASS, NULL, WS_CHILD | WS_VISIBLE, 5, 5, 475, 40, hwnd, 0, *hMainInstance, 0);
    hStatusbar = CreateWindowEx(0, STATUSCLASSNAME, TEXT("Klikniêæ: 0"), WS_CHILD | WS_VISIBLE, 0, 0, 0, 0, hwnd, 0, *hMainInstance, 0);
    hListbox = CreateWindowEx(0, WC_LISTBOX, NULL, WS_CHILD | WS_VISIBLE | WS_VSCROLL | ES_AUTOHSCROLL, 5, 50, 475, 100, hwnd, 0, *hMainInstance, 0);
    break;
  case WM_PAINT:
    hdc = BeginPaint(hwnd, &ps);

    EndPaint(hwnd, &ps);
    break;
  case WM_COMMAND:
    switch (wParam)
    {
    default:
      break;
    }
    break;
  default:
    return DefWindowProc(hwnd, message, wParam, lParam);
  }
  return 0;
}