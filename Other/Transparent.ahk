;
; AutoHotkey Version: 1.0.46.00
; Language:       English
; Platform:       WinNT 5.0+
; Author:         numEric
;
; Script Function:
;	Control window transparency with a wheel mouse.
;
; Usage: Hold <Ctrl> + <Shift> down and:
;     - Turn the mouse wheel to adjust the opacity of the hovered window;
;  or - Click the middle button to see the current opacity level for the hovered window.
; (The opacity shows in a tooltip.)
;
#NoEnv
#NoTrayIcon
#SingleInstance Force
#MaxThreadsPerHotkey 10
#MaxHotkeysPerInterval 200

OnExit, Cleanup
SetBatchLines, -1

AlphaIncrement := 8.5

#MButton::
   Gosub, WinGetTransparency
   Gosub, WinSetTransparency
   Gosub, ToolTipCreate
Return

#WheelDown::
   Gosub, WinGetTransparency
   Trans0 -= 10
   Gosub, WinSetTransparency
   Gosub, ToolTipCreate
Return

#WheelUp::
   Gosub, WinGetTransparency
   Trans0 += 10
   Gosub, WinSetTransparency
   Gosub, ToolTipCreate
Return

WinGetTransparency:
   MouseGetPos, , , hWnd
   If (Trans_%hWnd% = "")
   {
      Trans_%hWnd% := 100
   }
   Trans := Trans_%hWnd%
   Trans0 := Trans
Return

WinSetTransparency:
   WinGetClass, WindowClass, ahk_id %hWnd%
   If (WindowClass = "Progman")
   {
      Return
   }
   Trans0 := (Trans0 < 10) ? 10 : (Trans0 > 100) ? 100 : Trans0
   Alpha0 := Trans * 2.55		; Init. Alpha
   Alpha := Round(Trans0 * 2.55)	; Final Alpha
   Trans := Trans0
   Trans_%hWnd% := Trans
   a := Alpha - Alpha0
   b := AlphaIncrement
   b *= (a < 0) ? -1 : 1	; Signed increment
   a := Abs(a)				; Abs. iteration range
   Loop
   {
      Alpha0 := Round(Alpha0)
      WinSet, Trans, %Alpha0%, ahk_id %hWnd%
      If (Alpha0 = Alpha)
      {
         If (Alpha = 255)
         {
            If hWnd Not In %CleanupList%
            {
               CleanupList = %CleanupList%%hWnd%`,
               SetTimer, Cleanup, 10000
            }
         }
         Else
         {
            StringReplace, CleanupList, CleanupList, %hWnd%`,, , 1
         }
         Break
      }
      Else If (a >= AlphaIncrement)
      {
         Alpha0 += b
         a -= AlphaIncrement
      }
      Else
      {
         Alpha0 := Alpha
      }
   }
Return

ToolTipCreate:
   c := Floor(Trans / 4)
   d := 25 - c
   ToolTipText := "Opacity: "
   Loop, %c%
   {
      ToolTipText .= "|"
   }
   If (c > 0)
   {
      ToolTipText .= " "
   }
   ToolTipText .= Trans . "%"
   If (d > 0)
   {
      ToolTipText .= " "
   }
   Loop, %d%
   {
      ToolTipText .= "|"
   }
   ToolTip, %ToolTipText%
   MouseGetPos, MouseX0, MouseY0
   SetTimer, ToolTipDestroy
Return

ToolTipDestroy:
   If (A_TimeIdle < 1000)
   {
      MouseGetPos, MouseX, MouseY
      If (MouseX = MouseX0 && MouseY = MouseY0)
      {
         Return
      }
   }
   SetTimer, ToolTipDestroy, Off
   ToolTip
Return

Cleanup:
   Loop, Parse, CleanupList, `,
   {
      StringReplace, CleanupList, CleanupList, %A_LoopField%`,, , 1
      If (A_LoopField != "")
      {
         WinSet, Trans, Off, ahk_id %A_LoopField%
      }
   }
   If (A_ExitReason = "")
   {
      SetTimer, Cleanup, Off
   }
   Else
   {
      ExitApp
   }
Return