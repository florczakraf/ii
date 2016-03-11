#include <windows.h>
#include <Strsafe.h>
#include "resource.h"

INT_PTR CALLBACK DialogBoxWindowProcedure(HWND, UINT, WPARAM, LPARAM);

int WINAPI WinMain(HINSTANCE hThisInstance, HINSTANCE hPrevInstance,
  LPSTR lpszArgument, int nFunsterStil)
{
  DialogBox(hThisInstance, MAKEINTRESOURCE(IDD_DIALOG1), NULL, DialogBoxWindowProcedure);
}

INT_PTR CALLBACK DialogBoxWindowProcedure(HWND hwnd, UINT message,
  WPARAM wParam, LPARAM lParam)
{
  LPSTR bufNazwa, bufAdres, bufCykl;
  TCHAR buf[500];

  switch (message)
  {
  case WM_INITDIALOG:
    SendMessage(GetDlgItem(hwnd, IDC_COMBO1), CB_ADDSTRING, 0, TEXT("3-letnie"));
    SendMessage(GetDlgItem(hwnd, IDC_COMBO1), CB_ADDSTRING, 0, TEXT("3,5-letnie"));
    SendMessage(GetDlgItem(hwnd, IDC_COMBO1), CB_ADDSTRING, 0, TEXT("5-letnie"));
    return TRUE;
  case WM_DESTROY:
    EndDialog(hwnd, 0);
    break;
  case WM_COMMAND:
    switch (LOWORD(wParam))
    {
    case IDOK:
      bufNazwa = (LPSTR)LocalAlloc(GPTR, 100);
      bufAdres = (LPSTR)LocalAlloc(GPTR, 100);
      bufCykl = (LPSTR)LocalAlloc(GPTR, 100);

      GetWindowText(GetDlgItem(hwnd, IDC_EDIT1), bufNazwa, 100);
      GetWindowText(GetDlgItem(hwnd, IDC_EDIT2), bufAdres, 100);
      GetWindowText(GetDlgItem(hwnd, IDC_COMBO1), bufCykl, 100);

      StringCchCopy(buf, 500, bufNazwa);
      StringCchCat(buf, 400, "\n");
      StringCchCat(buf, 500, bufAdres);
      StringCchCat(buf, 300, TEXT("\nStudia "));
      StringCchCat(buf, 250, bufCykl);
      if (IsDlgButtonChecked(hwnd, IDC_CHECK1) == BST_CHECKED)
        StringCchCat(buf, 200, TEXT("\ndzienne"));

      if (IsDlgButtonChecked(hwnd, IDC_CHECK2) == BST_CHECKED)
        StringCchCat(buf, 100, TEXT("\nuzupe³niaj¹ce"));

      MessageBox(hwnd, buf, TEXT("Uczelnia"), 0);

      LocalFree(bufNazwa);
      LocalFree(bufAdres);
      LocalFree(bufCykl);

      break;
    case IDCANCEL:
      EndDialog(hwnd, 0);
      return TRUE;
    }
  }
  return 0;
}
