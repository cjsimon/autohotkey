/*
Name: Volume OSD
Version 1.0 (Tue May 28, 2013)
Created: Tue May 28, 2013
Author: tidbit
Credit: Bugz000 - ASCII progress bar.
*/

GroupAdd,mplayer,Windows Media Player
GroupAdd,mplayer,ahk_class WMPTransition

#NoEnv
#NoTrayIcon
#SingleInstance Force
#MaxHotkeysPerInterval 200

#MButton::
   ; Toggle the master mute (set it to the opposite state)
   SoundSet, +1, , mute
   
   ; Pause the media player
   Send, {Media_Play_Pause} ; Glitch that activates winkey
   ;WinWait, Windows Media Player, 
   ;IfWinNotActive, Windows Media Player, , WinActivate, Windows Media Player, 
   ;WinWaitActive, Windows Media Player,
   ;Send, ^p
   
   SoundGet, ismute, , mute
   muteMessage := ismute = "ON" ? "Mute" : "Playing"
   
   ; Display it and turn off the display
   ;ToolTip % muteMessage, MouseX, % MouseY
   SetTimer, KillTip, 500
Return

#WheelDown::
#WheelUp::
   ; get the current volume
   SoundGet, volval
   
   ; determine if we should add or subtract
   if (InStr(A_ThisHotkey, "down"))
      volval-=5
   Else if (InStr(A_ThisHotkey, "up"))
      volval+=5
   ChangeVolume(volval)
Return

ChangeVolume(volval)
{
   ; Clamp the value between 0 and 100. Then set it.
   volval:=clamp(volval)
   SoundSet, volval
   
   ; Display it and turn off the display
   ToolTip % ASCIIBar(volval), MouseX, % MouseY
   SetTimer, KillTip, 500
}

KillTip:
   Tooltip
   ;SetTimer, KillTip, 500
Return

Clamp(in, min=0, max=100)
{
   return ((in<min) ? min : (in>max) ? max : in)
}

ASCIIBar(Current, Max=100, Length=25, Locked = 0)
{
   Empty := "-"
   Full := "o"
   Percent := (Current / Max) * 100
   ; Keeps the length in between 4 and 97 if on
   if (Locked = 1)
      length := length > 97 ? 97 : length < 4 ? 4 : length
   percent := percent > 100 ? 100 : percent < 0 ? 0 : percent
   Loop % round(((percent / 100) * length), 0)
      Progress .= Full
   loop % Length - round(((percent / 100) * length), 0)
      Progress .= Empty
   return "[" progress "] " round(percent, 0) "%"
}