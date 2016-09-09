#NoEnv
#NoTrayIcon
#SingleInstance Force

#T::
If DllCall( "IsWindowVisible", UInt, WinExist( "ahk_class Shell_TrayWnd" ) )
     WinHide ahk_class Shell_TrayWnd
else WinShow ahk_class Shell_TrayWnd
Return