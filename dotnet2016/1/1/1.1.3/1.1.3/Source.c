#include <windows.h>
#include <CommCtrl.h>
#include <Strsafe.h>
#include <stdlib.h>

#define ID_BTN_AKCEPTUJ 101
#define ID_BTN_ANULUJ 102
#define ID_CHK_DZIENNE 103
#define ID_CHK_UZUPELNIAJACE 104
#define ID_CMB_CYKL 105



/* Deklaracja wyprzedzająca: funkcja obsługi okna */
LRESULT CALLBACK WindowProcedure(HWND, UINT, WPARAM, LPARAM);
/* Nazwa klasy okna */
char szClassName[] = "WindowClass";

HWND frmUczelnia, btnAkceptuj, btnAnuluj, frmStudia, txtNazwa, txtAdres, cmbCykl,
     chkDzienne, chkUzupelniajace;

HINSTANCE * hMainInstance;

int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nShowCmd)
{
  hMainInstance = &hInstance;

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
    TEXT("Wybór uczelni"),
    WS_OVERLAPPEDWINDOW,
    CW_USEDEFAULT, CW_USEDEFAULT,
    500, 300,
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
  PAINTSTRUCT ps;
  HDC hdc;

  LPCWSTR lblNazwa = TEXT("Nazwa:");
  LPCWSTR lblAdres = TEXT("Adres:");
  LPCWSTR lblCykl = TEXT("Cykl nauki:");

  LPSTR bufNazwa, bufAdres, bufCykl;
  TCHAR buf[500];

  switch (message)
  {
  case WM_DESTROY:
    PostQuitMessage(0);
    break;
  case WM_CREATE:
    frmUczelnia = CreateWindowEx(0, WC_BUTTON, TEXT("Uczelnia"), WS_CHILD | BS_GROUPBOX | WS_VISIBLE, 5, 5, 475, 100, hwnd, 0, *hMainInstance, 0);
    frmStudia = CreateWindowEx(0, WC_BUTTON, TEXT("Rodzaj studiów"), WS_CHILD | BS_GROUPBOX | WS_VISIBLE, 5, 105, 475, 100, hwnd, 0, *hMainInstance, 0);
    txtNazwa = CreateWindowEx(WS_EX_CLIENTEDGE, WC_EDIT, "", WS_CHILD | WS_VISIBLE, 70, 25, 390, 20, frmUczelnia, 0, *hMainInstance, 0);
    txtAdres = CreateWindowEx(WS_EX_CLIENTEDGE, WC_EDIT, "", WS_CHILD | WS_VISIBLE, 70, 55, 390, 20, frmUczelnia, 0, *hMainInstance, 0);
    cmbCykl = CreateWindowEx(0, TEXT("COMBOBOX"), "", WS_CHILD | CBS_DROPDOWN | WS_VISIBLE, 100, 135, 370, 100, hwnd, ID_CMB_CYKL, *hMainInstance, 0);
    SendMessage(cmbCykl, CB_ADDSTRING, 0, TEXT("3-letnie"));
    SendMessage(cmbCykl, CB_ADDSTRING, 0, TEXT("3,5-letnie"));
    SendMessage(cmbCykl, CB_ADDSTRING, 0, TEXT("5-letnie"));
    chkDzienne = CreateWindowEx(0, WC_BUTTON, TEXT("dzienne"), WS_CHILD | WS_VISIBLE | BS_CHECKBOX, 100, 160, 80, 20, hwnd, ID_CHK_DZIENNE, *hMainInstance, 0);
    chkUzupelniajace = CreateWindowEx(0, WC_BUTTON, TEXT("uzupełniające"), WS_CHILD | WS_VISIBLE | BS_CHECKBOX, 230, 160, 140, 20, hwnd, ID_CHK_UZUPELNIAJACE, *hMainInstance, 0);
    btnAkceptuj = CreateWindowEx(0, WC_BUTTON, TEXT("Akceptuj"), WS_CHILD | WS_VISIBLE, 5, 220, 150, 30, hwnd, ID_BTN_AKCEPTUJ, *hMainInstance, 0);
    btnAnuluj = CreateWindowEx(0, WC_BUTTON, TEXT("Anuluj"), WS_CHILD | WS_VISIBLE, 330, 220, 150, 30, hwnd, ID_BTN_ANULUJ, *hMainInstance, 0);
    break;
  case WM_PAINT:
    hdc = BeginPaint(hwnd, &ps);
    TextOut(hdc, 15, 30, lblNazwa, 6);
    TextOut(hdc, 15, 60, lblAdres, 6);
    TextOut(hdc, 15, 135, lblCykl, 11);
    EndPaint(hwnd, &ps);
    break;
  case WM_COMMAND:
    switch (wParam)
    {
    case ID_BTN_ANULUJ:
      PostQuitMessage(0);
      break;
    case ID_BTN_AKCEPTUJ:

      bufNazwa = (LPSTR)LocalAlloc(GPTR, 100);
      bufAdres = (LPSTR)LocalAlloc(GPTR, 100);
      bufCykl = (LPSTR)LocalAlloc(GPTR, 100);

      GetWindowText(txtNazwa, bufNazwa, 100);
      GetWindowText(txtAdres, bufAdres, 100);
      GetWindowText(cmbCykl, bufCykl, 100);

      StringCchCopy(buf, 500, bufNazwa);
      StringCchCat(buf, 400, "\n");
      StringCchCat(buf, 500, bufAdres);
      StringCchCat(buf, 300, TEXT("\nStudia "));
      StringCchCat(buf, 250, bufCykl);
      if (IsDlgButtonChecked(hwnd, ID_CHK_DZIENNE) == BST_CHECKED)
        StringCchCat(buf, 200, TEXT("\ndzienne"));

      if (IsDlgButtonChecked(hwnd, ID_CHK_UZUPELNIAJACE) == BST_CHECKED)
        StringCchCat(buf, 100, TEXT("\nuzupełniające"));

      MessageBox(hwnd, buf, TEXT("Uczelnia"), 0);

      LocalFree(bufNazwa);
      LocalFree(bufAdres);
      LocalFree(bufCykl);

      break;
    case ID_CHK_DZIENNE:
      CheckDlgButton(hwnd, ID_CHK_DZIENNE, !IsDlgButtonChecked(hwnd, ID_CHK_DZIENNE));
      break;
    case ID_CHK_UZUPELNIAJACE:
      CheckDlgButton(hwnd, ID_CHK_UZUPELNIAJACE, !IsDlgButtonChecked(hwnd, ID_CHK_UZUPELNIAJACE));
      break;
    }
    break;
  default:
    return DefWindowProc(hwnd, message, wParam, lParam);
  }
  return 0;
}