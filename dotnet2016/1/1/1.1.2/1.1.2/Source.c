#include <windows.h>
#include <stdlib.h>

#define ID_TIMER 1
#define TICK 5
#define SPEED 3

/* Deklaracja wyprzedzaj¹ca: funkcja obs³ugi okna */
LRESULT CALLBACK WindowProcedure(HWND, UINT, WPARAM, LPARAM);
/* Nazwa klasy okna */
char szClassName[] = "KlasaOkna";

typedef struct
{
  int x, y;
} Vector2;

typedef struct
{
  int x, y;
  int r;
  Vector2 * velocity;
} Ball;


int left(Ball * b) { return b->x - b->r; }
int right(Ball * b) { return b->x + b->r; }
int top(Ball * b) { return b->y - b->r; }
int bottom(Ball * b) { return b->y + b->r; }

Vector2 * CreateVector2(int x, int y)
{
  Vector2 * v = malloc(sizeof(Vector2));
  v->x = x;
  v->y = y;
}

int xs, ys;

Ball * ball;

int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nShowCmd)
{

  ball = malloc(sizeof(Ball));
  ball->r = 10;
  ball->velocity = CreateVector2(SPEED, SPEED);


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
    TEXT("Zadanie 1.1.2"),
    WS_OVERLAPPEDWINDOW,
    CW_USEDEFAULT, CW_USEDEFAULT,
    512, 512,
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

  RECT rect;
  HDC hdc;

  PAINTSTRUCT ps;

  switch (message)
  {
  case WM_DESTROY:
    KillTimer(hwnd, ID_TIMER);
    PostQuitMessage(0);
    break;
  case WM_CREATE:
    SetTimer(hwnd, ID_TIMER, TICK, NULL);
    break;
  case WM_TIMER:

    ball->x += ball->velocity->x;
    ball->y += ball->velocity->y;

    if (left(ball) < 0)
      ball->velocity->x = SPEED;
    else if (right(ball) > xs)
      ball->velocity->x = -SPEED;
    
    if (top(ball) < 0)
      ball->velocity->y = SPEED;
    else if (bottom(ball) > ys)
      ball->velocity->y = -SPEED;

    GetClientRect(hwnd, &rect);
    InvalidateRect(hwnd, &rect, 1);

    break;
  case WM_SIZE:
    xs = LOWORD(lParam);
    ys = HIWORD(lParam);

    ball->x = xs / 2;
    ball->y = ys / 2;

    GetClientRect(hwnd, &rect);
    InvalidateRect(hwnd, &rect, 1);

    break;
  case WM_PAINT:

    hdc = BeginPaint(hwnd, &ps);
    // draw ball
    Ellipse(hdc, left(ball), top(ball), right(ball), bottom(ball));

    EndPaint(hwnd, &ps);

    break;
  default:
    return DefWindowProc(hwnd, message, wParam, lParam);
  }
  return 0;
}