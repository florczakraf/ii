/*
 * Problemy:
 * przy próbie drukowania: SE_ERR_NOASSOC --> There is no application associated with the given file name extension. This error will also be returned if you attempt to print a file that is not printable.
 */

#include <windows.h>
#include <Strsafe.h>
#include <Shlobj.h> // CSIDL_DESKTOPDIRECTORY

int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, PSTR szCmdLine, int iCmdShow)
{
  DWORD dwWrote;
  HANDLE hFile;

  char sTime[22];
  SYSTEMTIME time;

  GetSystemTime(&time);
  GetDateFormat(LOCALE_SYSTEM_DEFAULT, 0, &time, TEXT("dd-MM-yyyy"), sTime, 22);

  WCHAR path[MAX_PATH];

  SHGetSpecialFolderPath(HWND_DESKTOP, path, CSIDL_DESKTOPDIRECTORY, FALSE);
  
  StringCchCat(path, 200, TEXT("\\test.txt"));

  hFile = CreateFile(path, GENERIC_WRITE, 0, NULL, CREATE_ALWAYS, 0, NULL);
  if (hFile == INVALID_HANDLE_VALUE)
  {
    MessageBox(NULL, TEXT("Couldn't create file"), TEXT("Error"), 0);
    PostQuitMessage(0);
  }

  if (!WriteFile(hFile, sTime, 22, &dwWrote, NULL))
  {
    MessageBox(NULL, TEXT("Couldn't write to file"), TEXT("Error"), MB_ICONEXCLAMATION);
    PostQuitMessage(0);
  }

  int result = ShellExecute(0, "print", path, NULL, NULL, 0);

  if (result)
  {
    WCHAR buf[64];
    swprintf_s(buf, 64, TEXT("ShellExecute error while printing: %d"), result);

    MessageBox(0, buf, 0, 0);
  }
 
  CloseHandle(hFile);
}