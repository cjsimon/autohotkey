#NoEnv
#NoTrayIcon
#SingleInstance Force

~RButton::
	If(A_PriorHotKey = A_ThisHotKey and A_TimeSincePriorHotkey < 300) {
		Gosub Close
	}
	return

Close:
	; WinWait, ahk_class #32768
	Sleep 200
	Send {Esc}
	Send ^w
Return