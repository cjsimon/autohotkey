#SingleInstance Force
#NoTrayIcon
#Persistent
#NoEnv
SetBatchLines, -1
DetectHiddenWindows, On
SetWorkingDir, %A_ScriptDir%

; ` is an escape key. We want to use the ` key so we escape it using ``
Hotkey, !``, OnTop
Hotkey, #``, TransWindow
Return

OnTop:
Winset, Alwaysontop, , A
Return

TransWindow:
WinGet, Transparent, Transparent, A

if (!Transparent) {
	Transparent := 250
	subtract = 1
	Loop {
		Sleep, 2
		if (Transparent > 150) {
			subtract += 1
			Transparent -= subtract
			WinSet, Trans, %transparent%, A
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
			WinSet, Trans, %Transparent%, A
		} else {
			WinSet, Trans, Off, A ; Ensures no additional strain on resources (eg: video card)
			break
		}
	}
} Transparent := ""
Return