;	Simple Window Fade
;	------------------------------------------------------------
;	Created by: islanq
; 	islanq(@)gmail.com
; 	1/19/2015
;	------------------------------------------------------------
;	Usage: Alt + ` (Toggles window fade) On / Off
;	------------------------------------------------------------
 
#SingleInstance Force
#Persistent
#NoEnv
SetBatchLines, -1
DetectHiddenWindows, On
SetWorkingDir, %A_ScriptDir%
 
Hotkey, ~!LButton, TransWindow
Return
 
TransWindow:
CoordMode, Mouse, Screen
MouseGetPos,,, hWnd
 
	if (!hWnd) {			; Mouse cannot hidden window info
		WinGet, hwnd, ID, A	; Therefore we use the window active method.
	} 
 
WinGet, Transparent, Transparent, ahk_id %hwnd%
 
if (!Transparent) {
Transparent := 250
	subtract = 1
	Loop {
		Sleep, 2
		if (Transparent > 60) {
			subtract += 1
			Transparent -= subtract
			WinSet, Trans, %transparent%, ahk_id %hwnd%
		} else {
			break
		}
	} 
} else { 
Transparent := Transparent
	add = 1
	Loop {
		Sleep, 1
		if (Transparent < 250) {
			add += 1
			Transparent += add
			WinSet, Trans, %Transparent%, ahk_id %hwnd%
		} else {
			WinSet, Trans, Off, ahk_id %hwnd% ; Ensures no additional strain on resources (eg: video card)
			break
		}
	}
} Transparent := ""
return