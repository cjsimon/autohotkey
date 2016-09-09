#SingleInstance Force
#NoTrayIcon
#Persistent
#NoEnv

xmousedelay = 300 ; ms
zorder = 0 ; 0 or 1

SPI_GETACTIVEWINDOWTRACKING = 0x1000 ; bool
SPI_GETACTIVEWNDTRKZORDER   = 0x100C ; bool
SPI_GETACTIVEWNDTRKTIMEOUT  = 0x2002 ; dword
SPI_SETACTIVEWINDOWTRACKING = 0x1001
SPI_SETACTIVEWNDTRKZORDER   = 0x100D 
SPI_SETACTIVEWNDTRKTIMEOUT  = 0x2003

+CapsLock:: ; Use Shift+CapsLock to toggle x-mouse
DllCall("SystemParametersInfo", UInt, SPI_GETACTIVEWINDOWTRACKING, UInt, 0, UIntP, XmouseEnabled, UInt, 0)
if %Xmouseenabled% = 0 
{
	DllCall("SystemParametersInfo", UInt, SPI_SETACTIVEWINDOWTRACKING, UInt, 0, UInt, 1, UInt, 0)
	DllCall("SystemParametersInfo", UInt, SPI_SETACTIVEWNDTRKZORDER, UInt, 0, UInt, zorder, UInt, 0)
	DllCall("SystemParametersInfo", UInt, SPI_SETACTIVEWNDTRKTIMEOUT, UInt, 0, UInt, xmousedelay, UInt, 0)
	traytip, Active Window Hovering, Enabled, 1
	
	; To produce standard system sounds, specify an asterisk followed by a number as shown below. Note: the wait parameter has no effect in this mode.
	; *-1: Simple beep. If the sound card is not available, the sound is generated using the speaker.
	; *16: Hand (stop/error)
	; *32: Question
	; *48: Exclamation
	; *64: Asterisk (info)
	SoundPlay *64
} else {
	DllCall("SystemParametersInfo", UInt, SPI_SETACTIVEWINDOWTRACKING, UInt, 0, UInt, 0, UInt, 0)
	traytip, Active Window Hovering, Disabled, 1
	SoundPlay *16
}
return